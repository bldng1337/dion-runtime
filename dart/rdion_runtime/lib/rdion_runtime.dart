library rdion_runtime;

import 'package:rdion_runtime/rdion_runtime.dart';

export 'src/rust/api/simple.dart';
export 'src/rust/third_party/dion_runtime/permission.dart';
export 'src/rust/third_party/dion_runtime/jsextension.dart';
export 'src/rust/third_party/dion_runtime/datastructs.dart';
export 'src/rust/third_party/dion_runtime/settings.dart';
export 'src/rust/frb_generated.dart' show RustLib;

void setPermissionRequest(Function(PermissionRequest) listener) {
  final a=internalSetPermissionRequestListener();
  a.listen((request) {
    final answer=listener(request);
    if(answer is Future<bool>) {
      answer.then((value) {
        internalSendPermissionRequestAnswer(answer: value);
      });
      return;
    }
    internalSendPermissionRequestAnswer(answer: answer);
  });
}