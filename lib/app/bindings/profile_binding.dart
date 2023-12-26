import 'dart:js_util';

import 'package:get/get.dart';
import 'package:safuami/app/controllers/profile_controller.dart';

class ProfileBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<ProfileController>(() => ProfileController(newObject()));
  }
}