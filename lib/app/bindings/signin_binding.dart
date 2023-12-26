import 'dart:js_util';

import 'package:get/get.dart';
import 'package:safuami/app/controllers/signin_controller.dart';

class SigninBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<SigninController>(() => SigninController(newObject()));
  }
}