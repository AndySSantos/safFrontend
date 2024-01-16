import 'dart:js_util';

import 'package:get/get.dart';
import 'package:safuami/app/controllers/change_password_controller.dart';

class ChangePasswordBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ChangePasswordController>(() => ChangePasswordController(newObject()));
  }
}