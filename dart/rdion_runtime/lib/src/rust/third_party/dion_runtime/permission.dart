// This file is automatically generated, so please do not edit it.
// @generated by `flutter_rust_bridge`@ 2.4.0.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';
import 'package:freezed_annotation/freezed_annotation.dart' hide protected;
part 'permission.freezed.dart';

@freezed
sealed class Permission with _$Permission {
  const Permission._();

  const factory Permission.storagePermission({
    required String path,
    required bool write,
  }) = Permission_StoragePermission;
}
