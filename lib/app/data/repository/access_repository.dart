import 'package:safuami/app/data/model/error_handler.dart';
import 'package:safuami/app/data/model/server.dart';
import 'package:safuami/app/data/provider/access_provider.dart';
import 'package:safuami/app/middleware/custom_exception.dart';

AccessProvider accessProvider = AccessProvider();

class AccessRepository {
  Future<Server> getResponseServer() async {
    final raw = await accessProvider.getResponseServer();
    final data = raw.body;

    Server server = Server.fromJson(data);
    return server;
  }
}