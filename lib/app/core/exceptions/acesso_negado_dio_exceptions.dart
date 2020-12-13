import 'package:dio/dio.dart';

class AcessoNegadoDioException extends DioError {
  String mensagem;

  AcessoNegadoDioException(this.mensagem, {DioError exception})
      : super(
          request: exception.request,
          response: exception.response,
          type: exception.type,
          error: exception.error,
        );

  @override
  String toString() {
    return 'AcessoNegadoException(mensagem: $mensagem, exception: ${super.error}';
  }
}
