import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

// Базовый адрес и таймауты записаны только здесь.
// Dio создаётся один раз в app.dart и передаётся дальше через конструкторы.
abstract final class DioClient {
  static const String baseUrl = 'https://forgeapi.puppet.com/v3';

  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestHeader: false,
          responseHeader: false,
          responseBody: false,
          logPrint: (line) => debugPrint('[dio] $line'),
        ),
      );
    }
    return dio;
  }
}
