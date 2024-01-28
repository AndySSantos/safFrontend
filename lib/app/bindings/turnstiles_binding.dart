import 'dart:js_util';

import 'package:get/get.dart';
import 'package:safuami/app/controllers/turnstiles_controller.dart';

class TurnstilesBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<TurnstilesController>(() => TurnstilesController(newObject()));
  }
}