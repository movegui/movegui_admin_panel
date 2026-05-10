
import 'package:dio/dio.dart';
import 'package:movegui_admin_panel/config/env.dart';

class ApiService {
  final Env env;

  late final Dio dio;

  ApiService(this.env) {
    dio = Dio(
      BaseOptions(
        baseUrl: env.baseUrl,
      ),
    );

    if (env.enableLogs) {
      print(
        '🌍 API => ${env.apiUrl}',
      );
    }
  }
}