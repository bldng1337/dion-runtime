// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.8.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide protected;
part 'settings.freezed.dart';

// Rust type: RustOpaqueNom<flutter_rust_bridge::for_generated::RustAutoOpaqueInner<DropdownItem>>
abstract class DropdownItem implements RustOpaqueInterface {}

/// flutter_rust_bridge:non_opaque
class Setting {
  final Settingvalue val;
  final Settingtype settingtype;
  final SettingUI? ui;

  const Setting({
    required this.val,
    required this.settingtype,
    this.ui,
  });

  @override
  int get hashCode => val.hashCode ^ settingtype.hashCode ^ ui.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Setting &&
          runtimeType == other.runtimeType &&
          val == other.val &&
          settingtype == other.settingtype &&
          ui == other.ui;
}

@freezed
sealed class SettingUI with _$SettingUI {
  const SettingUI._();

  const factory SettingUI.pathSelection({
    required String label,
    required bool pickfolder,
  }) = SettingUI_PathSelection;
  const factory SettingUI.slider({
    required String label,
    required double min,
    required double max,
    required double step,
  }) = SettingUI_Slider;
  const factory SettingUI.checkbox({
    required String label,
  }) = SettingUI_Checkbox;
  const factory SettingUI.textbox({
    required String label,
  }) = SettingUI_Textbox;
  const factory SettingUI.dropdown({
    required String label,
    required List<DropdownItem> options,
  }) = SettingUI_Dropdown;
}

/// flutter_rust_bridge:non_opaque
enum Settingtype {
  extension_,
  entry,
  search,
  ;
}

@freezed
sealed class Settingvalue with _$Settingvalue {
  const Settingvalue._();

  const factory Settingvalue.string({
    required String val,
    required String defaultVal,
  }) = Settingvalue_String;
  const factory Settingvalue.number({
    required double val,
    required double defaultVal,
  }) = Settingvalue_Number;
  const factory Settingvalue.boolean({
    required bool val,
    required bool defaultVal,
  }) = Settingvalue_Boolean;
}
