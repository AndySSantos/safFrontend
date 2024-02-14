import 'dart:js_util';

import 'package:get/get.dart';
import 'package:safuami/app/controllers/facial_access_controller.dart';

class FacialAccessBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<FacialAccessController>(() => FacialAccessController(newObject()));
  }
}