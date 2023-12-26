import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safuami/app/controllers/check_controller.dart';

class CheckBinding implements Bindings {
@override
void dependencies() {
  Get.lazyPut<CheckController>(() => CheckController(newObject()));
  }
}