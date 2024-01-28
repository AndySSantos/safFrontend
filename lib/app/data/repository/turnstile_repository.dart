import 'package:safuami/app/data/model/error_handler.dart';
import 'package:safuami/app/data/model/server.dart';
import 'package:safuami/app/data/model/turnstile/turnstile.dart';
import 'package:safuami/app/data/provider/turnstile_provider.dart';
import 'package:safuami/app/middleware/custom_exception.dart';

TurnstileProvider turnstileProvider = TurnstileProvider();

class TurnstileRepository {



  Future<Object> getInfoTurnstile({required String turnstileId}) async {
    try {
      final raw = await turnstileProvider.findTurnstile(turnstileId: turnstileId);
      final data = raw.body;

      print(data);

      // Verificar el contenido de 'data' y manejar excepciones según los casos
      if (data.containsKey('location')) {
        return Turnstile.fromJson(data);
      } else if (data.containsKey('message') && data.containsKey('code')) {
        return ErrorHandler.fromJson(data);
      } else {
        throw CustomException('Respuesta inesperada del servidor');
      }
    } catch (e) {
      throw CustomException('Error de conexión');
    }
  }
  


}