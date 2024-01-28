import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safuami/app/data/model/error_handler.dart';
import 'package:safuami/app/data/model/turnstile/turnstile.dart';
import 'package:safuami/app/data/repository/turnstile_repository.dart';
import 'package:clipboard/clipboard.dart';

class InfoTurnstileController extends GetxController {
  final box = GetStorage();

  // Obtener la altura y el ancho del dispositivo
  double deviceWidth = 0.0;
  double deviceHeight = 0.0;
  int headerHeight = 0; //? (deviceHeight * 0.3).floor();
  int sectionHeight = 0; //? (deviceHeight * 0.6).floor();
  int footerHeight = 0; //? (deviceHeight * 0.1).floor();
  String name = '', ubication = '', urlPhoto = '', state = '';

  TurnstileRepository repository = TurnstileRepository();

  InfoTurnstileController(Size sizeMobil) {
    //invoqueRepository();
    name = "Puerta " +
        ((box.read('door') != 0) ? box.read('door').toString() : "Principal");
    ubication = SubCadena('(',box.read('ubication'),true);
    urlPhoto = box.read('urlPhoto');
    state = box.read('state');

    deviceWidth = sizeMobil.width;
    deviceHeight = sizeMobil.height;
    headerHeight = (deviceHeight * 0.3).floor();
    sectionHeight = (deviceHeight * 0.65).floor();
    footerHeight = (deviceHeight * 0.05).floor();
  }

  close_page() {
    Get.close(1);
  }

  copyInfo() {
    String location = SubCadena('(',box.read('ubication'), false);
    FlutterClipboard.copy(location).then(( value ) => print('copied: $location'));
    EasyLoading.showInfo('Ubicacion copiada');
  }

  invoqueRepository() async {
    final String idTurnstile = '65a769b46ec81f97a58c8eb1';
    final body = await repository.getInfoTurnstile(turnstileId: idTurnstile);

    print("Respuesta");
    print(body);
    //error handler
    if (body is ErrorHandler) {
      EasyLoading.showError(body.message);
    } else if (body is Turnstile) {
      //print(body.token);
      save_cache(body);
    }
  }

  void save_cache(Turnstile info) {
    box.write('door', info.gate);
    box.write('ubication', info.location);
    box.write('urlPhoto', info.urlPhoto);
    box.write('state', info.state);
  }

  String SubCadena(String caracter, String cadena, bool before) {
    // Buscar la posición del caracter
    int indiceParentesisAbierto = cadena.indexOf(caracter);

    if (indiceParentesisAbierto != -1) {
      // Si se encuentra el caacter, obtener la subcadena desde ese punto
      String subcadena = (before) ?cadena.substring(0,indiceParentesisAbierto) :cadena.substring(indiceParentesisAbierto+1,cadena.length-1);
      return subcadena;
    } else {
      return cadena;
    }
  }
}
