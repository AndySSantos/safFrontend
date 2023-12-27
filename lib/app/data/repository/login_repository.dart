import 'package:safuami/app/data/model/error_handler.dart';
import 'package:safuami/app/data/model/server.dart';
import 'package:safuami/app/data/model/token.dart';
import 'package:safuami/app/data/model/user/credentials.dart';
import 'package:safuami/app/data/provider/login_provider.dart';
import 'package:safuami/app/middleware/custom_exception.dart';

LoginProvider loginProvider = LoginProvider();


class LoginRepository {


  Future<Server> getResponseServer() async{
    final raw = await loginProvider.getResponseServer();
    final data = raw.body;

    Server server = Server.fromJson(data);
    return server;
  }


  Future<Object> postLogin({required String email, required String password}) async{
    try {
      final raw = await loginProvider.login(email: email, password: password);
      final data =raw.body;

      //print(data);
      
      // Verificar el contenido de 'data' y manejar excepciones según los casos
      if (data.containsKey('token')) {
        return Token.fromJson(data);
      } else if (data.containsKey('message') && data.containsKey('code')) {
        return ErrorHandler.fromJson(data);
      } else {
        throw CustomException('Respuesta inesperada del servidor');
      }
    } catch (e) {
      throw CustomException('Error de conexión');
    }
  }

  Future<Object> postSignin({required String email, required String password}) async{
    try {
      final raw = await loginProvider.signin(email: email, password: password);
      final data =raw.body;
      
      // Verificar el contenido de 'data' y manejar excepciones según los casos
      if (data.containsKey('token')) {
        return Token.fromJson(data);
      } else if (data.containsKey('message') && data.containsKey('code')) {
        return ErrorHandler.fromJson(data);
      } else {
        throw CustomException('Respuesta inesperada del servidor');
      }
    } catch (e) {
      throw CustomException('Error de conexión');
    }
  }

  Future<Object> postSendCode({required String userId}) async{
    try {
      final raw = await loginProvider.sendCode(userId: userId);
      final data =raw.body;
      
      // Verificar el contenido de 'data' y manejar excepciones según los casos
      if (data.containsKey('message') && data.containsKey('code')) {
        return ErrorHandler.fromJson(data);
      } else {
        throw CustomException('Respuesta inesperada del servidor');
      }
    } catch (e) {
      throw CustomException('Error de conexión');
    }
  }


  Future<Object> postVerifyCode({required String userId, required String code}) async{
    try {
      final raw = await loginProvider.verifyCode(userId: userId, code: code);
      final data =raw.body;
      
      // Verificar el contenido de 'data' y manejar excepciones según los casos
      if (data.containsKey('message') && data.containsKey('code')) {
        return ErrorHandler.fromJson(data);
      } else {
        throw CustomException('Respuesta inesperada del servidor');
      }
    } catch (e) {
      throw CustomException('Error de conexión');
    }
  }

  /*
  final MyApi api;

  LoginRepository(this.api);

  getAll(){
    return api.getAll();
  }
  getId(id){
    return api.getId(id);
  }
  delete(id){
    return api.delete(id);
  }
  edit(obj){
    return api.edit( obj );
  }
  add(obj){
      return api.add( obj );
  }
  */
}