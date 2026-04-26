//! Android binary XML (AXML) parser
//!
//! Parses the binary AndroidManifest.xml format used in APK files.

use anyhow::{bail, Result};
use byteorder::{LittleEndian, ReadBytesExt};
use std::collections::HashMap;
use std::io::{Cursor, Read, Seek, SeekFrom};

// Chunk types
const CHUNK_AXML_FILE: u16 = 0x0003;
const CHUNK_STRING_POOL: u16 = 0x0001;
const CHUNK_RESOURCE_MAP: u16 = 0x0180;
const CHUNK_START_NAMESPACE: u16 = 0x0100;
const CHUNK_END_NAMESPACE: u16 = 0x0101;
const CHUNK_START_TAG: u16 = 0x0102;
const CHUNK_END_TAG: u16 = 0x0103;
const CHUNK_TEXT: u16 = 0x0104;

// Attribute types
const TYPE_STRING: u32 = 0x03;
const TYPE_INT_DEC: u32 = 0x10;
const TYPE_INT_HEX: u32 = 0x11;
const TYPE_INT_BOOLEAN: u32 = 0x12;

/// Parsed XML element
#[derive(Debug, Clone)]
pub struct XmlElement {
    pub name: String,
    pub attributes: HashMap<String, String>,
    pub children: Vec<XmlElement>,
}

/// Simple XML document structure
#[derive(Debug)]
pub struct XmlDocument {
    pub root: Option<XmlElement>,
}

/// Binary XML parser
pub struct BinaryXmlParser {
    string_pool: Vec<String>,
}

impl BinaryXmlParser {
    pub fn new() -> Self {
        Self {
            string_pool: Vec::new(),
        }
    }

    /// Parse binary XML data
    pub fn parse(&mut self, data: &[u8]) -> Result<XmlDocument> {
        let mut cursor = Cursor::new(data);

        // Read file header
        let magic = cursor.read_u16::<LittleEndian>()?;
        if magic != CHUNK_AXML_FILE {
            bail!("Invalid AXML magic: 0x{:04x}", magic);
        }

        let _header_size = cursor.read_u16::<LittleEndian>()?;
        let _file_size = cursor.read_u32::<LittleEndian>()?;

        // Parse chunks
        let mut element_stack: Vec<XmlElement> = Vec::new();
        let mut root: Option<XmlElement> = None;

        while cursor.position() < data.len() as u64 {
            let chunk_start = cursor.position();
            let chunk_type = cursor.read_u16::<LittleEndian>()?;
            let _header_size = cursor.read_u16::<LittleEndian>()?;
            let chunk_size = cursor.read_u32::<LittleEndian>()?;

            match chunk_type {
                CHUNK_STRING_POOL => {
                    self.parse_string_pool(&mut cursor, chunk_start, chunk_size)?;
                }
                CHUNK_START_TAG => {
                    let element = self.parse_start_tag(&mut cursor)?;
                    element_stack.push(element);
                }
                CHUNK_END_TAG => {
                    let _line = cursor.read_u32::<LittleEndian>()?;
                    let _comment = cursor.read_u32::<LittleEndian>()?;
                    let _ns = cursor.read_u32::<LittleEndian>()?;
                    let _name = cursor.read_u32::<LittleEndian>()?;

                    if let Some(element) = element_stack.pop() {
                        if let Some(parent) = element_stack.last_mut() {
                            parent.children.push(element);
                        } else {
                            root = Some(element);
                        }
                    }
                }
                CHUNK_RESOURCE_MAP | CHUNK_START_NAMESPACE | CHUNK_END_NAMESPACE | CHUNK_TEXT => {
                    // Skip these chunks
                }
                _ => {
                    // Skip unknown chunks
                }
            }

            // Move to next chunk
            cursor.seek(SeekFrom::Start(chunk_start + chunk_size as u64))?;
        }

        Ok(XmlDocument { root })
    }

    fn parse_string_pool(
        &mut self,
        cursor: &mut Cursor<&[u8]>,
        chunk_start: u64,
        _chunk_size: u32,
    ) -> Result<()> {
        let string_count = cursor.read_u32::<LittleEndian>()? as usize;
        let _style_count = cursor.read_u32::<LittleEndian>()?;
        let flags = cursor.read_u32::<LittleEndian>()?;
        let strings_start = cursor.read_u32::<LittleEndian>()?;
        let _styles_start = cursor.read_u32::<LittleEndian>()?;

        let is_utf8 = (flags & (1 << 8)) != 0;

        // Read string offsets
        let mut offsets = Vec::with_capacity(string_count);
        for _ in 0..string_count {
            offsets.push(cursor.read_u32::<LittleEndian>()?);
        }

        // Read strings
        let strings_abs_start = chunk_start + 8 + strings_start as u64;

        for offset in offsets {
            cursor.seek(SeekFrom::Start(strings_abs_start + offset as u64))?;

            let s = if is_utf8 {
                self.read_utf8_string(cursor)?
            } else {
                self.read_utf16_string(cursor)?
            };

            self.string_pool.push(s);
        }

        Ok(())
    }

    fn read_utf8_string(&self, cursor: &mut Cursor<&[u8]>) -> Result<String> {
        // UTF-8 length encoding
        let char_len = cursor.read_u8()? as usize;
        let _char_len = if char_len > 0x7F {
            let second = cursor.read_u8()? as usize;
            ((char_len & 0x7F) << 8) | second
        } else {
            char_len
        };

        let byte_len = cursor.read_u8()? as usize;
        let byte_len = if byte_len > 0x7F {
            let second = cursor.read_u8()? as usize;
            ((byte_len & 0x7F) << 8) | second
        } else {
            byte_len
        };

        let mut buf = vec![0u8; byte_len];
        cursor.read_exact(&mut buf)?;

        // Consume the null terminator byte
        cursor.read_u8()?;

        Ok(String::from_utf8_lossy(&buf).to_string())
    }

    fn read_utf16_string(&self, cursor: &mut Cursor<&[u8]>) -> Result<String> {
        let len = cursor.read_u16::<LittleEndian>()? as usize;
        let len = if len > 0x7FFF {
            let second = cursor.read_u16::<LittleEndian>()? as usize;
            ((len & 0x7FFF) << 16) | second
        } else {
            len
        };

        let mut chars = Vec::with_capacity(len);
        for _ in 0..len {
            chars.push(cursor.read_u16::<LittleEndian>()?);
        }

        // Consume the null terminator (UTF-16: 2 bytes)
        cursor.read_u16::<LittleEndian>()?;

        Ok(String::from_utf16_lossy(&chars))
    }

    fn parse_start_tag(&mut self, cursor: &mut Cursor<&[u8]>) -> Result<XmlElement> {
        let _line = cursor.read_u32::<LittleEndian>()?;
        let _comment = cursor.read_u32::<LittleEndian>()?;
        let _ns_idx = cursor.read_u32::<LittleEndian>()?;
        let name_idx = cursor.read_u32::<LittleEndian>()?;
        let _attr_start = cursor.read_u16::<LittleEndian>()?;
        let _attr_size = cursor.read_u16::<LittleEndian>()?;
        let attr_count = cursor.read_u16::<LittleEndian>()?;
        let _id_idx = cursor.read_u16::<LittleEndian>()?;
        let _class_idx = cursor.read_u16::<LittleEndian>()?;
        let _style_idx = cursor.read_u16::<LittleEndian>()?;

        let name = self.get_string(name_idx as usize);
        let mut attributes = HashMap::new();

        for _ in 0..attr_count {
            let _attr_ns = cursor.read_u32::<LittleEndian>()?;
            let attr_name_idx = cursor.read_u32::<LittleEndian>()?;
            let attr_value_string = cursor.read_u32::<LittleEndian>()?;
            let _attr_type_size = cursor.read_u16::<LittleEndian>()?;
            let _attr_res0 = cursor.read_u8()?;
            let attr_data_type = cursor.read_u8()? as u32;
            let attr_data = cursor.read_u32::<LittleEndian>()?;

            let attr_name = self.get_string(attr_name_idx as usize);
            let attr_value = match attr_data_type {
                TYPE_STRING => {
                    if attr_value_string != 0xFFFFFFFF {
                        self.get_string(attr_value_string as usize)
                    } else {
                        String::new()
                    }
                }
                TYPE_INT_DEC | TYPE_INT_HEX => attr_data.to_string(),
                TYPE_INT_BOOLEAN => {
                    if attr_data != 0 {
                        "true".to_string()
                    } else {
                        "false".to_string()
                    }
                }
                _ => attr_data.to_string(),
            };

            attributes.insert(attr_name, attr_value);
        }

        Ok(XmlElement {
            name,
            attributes,
            children: Vec::new(),
        })
    }

    fn get_string(&self, idx: usize) -> String {
        self.string_pool.get(idx).cloned().unwrap_or_default()
    }
}

impl XmlDocument {
    /// Find elements by name recursively
    pub fn find_elements(&self, name: &str) -> Vec<&XmlElement> {
        let mut results = Vec::new();
        if let Some(root) = &self.root {
            self.find_elements_recursive(root, name, &mut results);
        }
        results
    }

    fn find_elements_recursive<'a>(
        &self,
        element: &'a XmlElement,
        name: &str,
        results: &mut Vec<&'a XmlElement>,
    ) {
        if element.name == name {
            results.push(element);
        }
        for child in &element.children {
            self.find_elements_recursive(child, name, results);
        }
    }
}
