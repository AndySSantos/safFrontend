import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safuami/app/data/model/user/credentials.dart';

const baseUrl = 'http://127.0.0.1:8000'; //endpoint

class LoginProvider extends GetConnect {


  Future<Response> getResponseServer() async{ 
    final raw =  await get("$baseUrl/");

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

  Future<Response> login({required String email, required String password}) => post('$baseUrl/login',{'email':email,'password':password});

  Future<Response> signin({required String email, required String password}) => post('$baseUrl/users',{'email':email,'password':password});
  
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