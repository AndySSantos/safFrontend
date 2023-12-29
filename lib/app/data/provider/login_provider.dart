import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safuami/app/data/model/user/credentials.dart';

const baseUrl = 'http://10.0.2.2:8000'; //'http://127.0.0.1:8000'; //endpoint

class LoginProvider extends GetConnect {
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
/*
  Future<Response> login({required String email, required String password}) async{
    final data = {'email':email,'password':password};
    final raw = await post("$baseUrl/login", body= data);
  }
*/

  Future<Response> login({required String email, required String password}) =>
      post('$baseUrl/login', {'email': email, 'password': password});

  Future<Response> signin({required String email, required String password}) =>
      post('$baseUrl/users', {'email': email, 'password': password});

  Future<Response> sendCode({required String userId}) =>
      post('$baseUrl/users/$userId/sendConfirmationCode', {});

  Future<Response> verifyCode({required String userId, required String code}) =>
      post('$baseUrl/users/$userId/verifyCodeConfirmation', {'code': code});

  Future<Response> getProfile({required String userId}) =>
      get('$baseUrl/users/$userId');
  /**
   * {
  "currentPassword": "panda35",
  "newUser": "",
  "newPassword":"",
  "newEmail": "andyleonardos2@titlani.uam.mx"
}
   */

  Future<Response> putUser(
          {required String userId,
          required String currentPassword,
          required String newUser,
          required String newPassword,
          required String newEmail}) =>
      put('$baseUrl/users/$userId', {
        "currentPassword": currentPassword,
        "newUser": newUser,
        "newPassword": newPassword,
        "newEmail": newEmail
      });

  /*
  
  // Get request
  Future<Response> getUser(int id) => get('http://youapi/users/id');
  // Post request
  Future<Response> postUser(Map data) => post('http://youapi/users', body: data);
  // Post request with File
  Future<Response<CasesModel>> postCases(List<int> image) {
    final form = FormData({
      'file': MultipartFile(image, filename: 'avatar.png'),
      'otherFile': MultipartFile(image, filename: 'cover.png'),
    });
    return post('http://youapi/users/upload', form);
  }
  GetSocket userMessages() {
    return socket('https://yourapi/users/socket');
  }
  */
}
