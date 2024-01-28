import 'dart:js_util';

import 'package:get/get.dart';
import 'package:safuami/app/controllers/info_turnstile_controller.dart';

class InfoTurnstileBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<InfoTurnstileController>(() => InfoTurnstileController(newObject()));
  }
}