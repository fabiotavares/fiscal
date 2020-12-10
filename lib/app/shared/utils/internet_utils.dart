import 'dart:io';

class InternetUtils {
  static Future<bool> conexaoDisponivel() async {
    // verifica se há conexão com internet disponível
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
