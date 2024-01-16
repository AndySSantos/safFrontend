import 'dart:js_util';

import 'package:get/get.dart';
import 'package:safuami/app/controllers/forgot_password_controller.dart';

class ForgotPasswordBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController(newObject()));
  }
}