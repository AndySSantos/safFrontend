import 'dart:js_util';

import 'package:get/get.dart';
import 'package:safuami/app/controllers/home_controller.dart';

class HomeBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<HomeController>(() => HomeController(newObject()));
  }
}