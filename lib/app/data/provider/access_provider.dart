import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

const baseUrl = 'http://127.0.0.1:8000';//'http://10.0.2.2:8000'; //'http://127.0.0.1:8000'; //endpoint

class AccessProvider extends GetConnect {

  Future<Response> getResponseServer() async {
    final raw = await get("$baseUrl/");

    switch (raw.statusCode) {
      case 200:
        return raw;

      case 500:
        throw "Servidor no conectado";

      case 404:
        throw "no encontrado";

      default:
        throw "Otro error $raw.statusCode";
    }

    //print(raw.body);
  }


}
