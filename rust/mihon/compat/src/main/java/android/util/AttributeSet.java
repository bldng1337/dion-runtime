package android.util;

/**
 * Minimal AttributeSet stub.
 */
public interface AttributeSet {
    int getAttributeCount();
    String getAttributeName(int index);
    String getAttributeValue(int index);
    String getAttributeValue(String namespace, String name);
    String getPositionDescription();
    int getAttributeNameResource(int index);
    int getAttributeListValue(String namespace, String attribute, String[] options, int defaultValue);
    boolean getAttributeBooleanValue(String namespace, String attribute, boolean defaultValue);
    int getAttributeResourceValue(String namespace, String attribute, int defaultValue);
    int getAttributeIntValue(String namespace, String attribute, int defaultValue);
    int getAttributeUnsignedIntValue(String namespace, String attribute, int defaultValue);
    float getAttributeFloatValue(String namespace, String attribute, float defaultValue);
    int getIdAttributeResourceValue(int defaultValue);
    String getClassAttribute();
    String getIdAttribute();
    String getStyleAttribute();
}
