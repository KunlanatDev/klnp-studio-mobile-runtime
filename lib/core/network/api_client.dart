import 'package:dio/dio.dart';

import '../config/app_config.dart';

class ApiClient {
  late final Dio dio;

  ApiClient({Dio? customDio}) {
    dio = customDio ??
        Dio(
          BaseOptions(
            baseUrl: AppConfig.apiBaseUrl,
            connectTimeout: const Duration(seconds: 15),
            receiveTimeout: const Duration(seconds: 30),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
            },
          ),
        );
  }
}

