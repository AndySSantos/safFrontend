import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safuami/app/data/model/error_handler.dart';
import 'package:safuami/app/data/model/turnstile/turnstile.dart';
import 'package:safuami/app/data/repository/turnstile_repository.dart';
import 'package:safuami/app/routes/pages.dart';


class TurnstilesController extends GetxController {

  final box = GetStorage();

   // Obtener la altura y el ancho del dispositivo
  double deviceWidth = 0.0;
  double deviceHeight = 0.0;
  int headerHeight = 0; //? (deviceHeight * 0.3).floor();
  int sectionHeight = 0; //? (deviceHeight * 0.6).floor();
  int footerHeight = 0; //? (deviceHeight * 0.1).floor();

  TurnstileRepository turnstileRepository = TurnstileRepository();

  TurnstilesController(Size sizeMobil) {
    deviceWidth = sizeMobil.width;
    deviceHeight = sizeMobil.height;
    headerHeight = (deviceHeight * 0.3).floor();
    sectionHeight = (deviceHeight * 0.65).floor();
    footerHeight = (deviceHeight * 0.05).floor();
  }

  close_page(){
    Get.close(1);
  }
  
  info_turnstile(String idTurnstile){

    if (idTurnstile.isEmpty) {
      EasyLoading.showError('Respuesta no recibida');
      return;
    }
    invoqueTurnstileRepo(idTurnstile);

  }

    invoqueTurnstileRepo(String idTurnstile) async{
    final body = await turnstileRepository.getInfoTurnstile(turnstileId: idTurnstile );

    //print("Respuesta");
    //print(body);
    //error handler
    if (body is ErrorHandler) {
      EasyLoading.showError(body.message);    
    }
    else if(body is Turnstile){
      //print(body.token);
      save_cache(body);

      Get.toNamed(Routes.INFO_TURNSTILE);
    }
  }

  void save_cache(Turnstile info) {
    box.write('door', info.gate);
    box.write('ubication', info.location);
    box.write('urlPhoto', info.urlPhoto);
    box.write('state', info.state);
    
  }
}