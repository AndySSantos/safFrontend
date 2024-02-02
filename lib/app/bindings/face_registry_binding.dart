import 'dart:js_util';

import 'package:get/get.dart';
import 'package:safuami/app/controllers/face_registry_controller.dart';

class FaceRegistryBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<FaceRegistryController>(() => FaceRegistryController(newObject()));
  }
}