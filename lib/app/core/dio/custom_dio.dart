import 'package:fiscal/app/core/dio/auth_interceptor_wrapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomDio {
  static CustomDio _simpleInstance;
  static CustomDio _authInstance;
  Dio _dio;

  BaseOptions options = BaseOptions(
    baseUrl: DotEnv().env['base_url'],
    connectTimeout: int.parse(DotEnv().env['dio_connectTimeout']),
    receiveTimeout: int.parse(DotEnv().env['dio_receiveTimeout']),
  );

  // construtor privado para uma instância SEM autenticação
  CustomDio._() {
    _dio = Dio(options);
  }

  // construtor privado para uma instância COM autenticação
  CustomDio._auth() {
    _dio = Dio(options);
    _dio.interceptors.add(AuthInterceptorWrapper());
  }

  // sem autenticação
  static Dio get instance {
    // atribui valor se for nulo apenas
    _simpleInstance ??= CustomDio._();
    return _simpleInstance._dio;
  }

  // com autenticação
  static Dio get authInstance {
    // atribui valor se for nulo apenas
    _authInstance ??= CustomDio._auth();
    return _authInstance._dio;
  }
}
