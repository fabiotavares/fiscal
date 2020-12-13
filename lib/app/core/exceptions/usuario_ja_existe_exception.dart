class UsuarioJaExisteException implements Exception {
  String mensagem;

  UsuarioJaExisteException(this.mensagem);

  @override
  String toString() {
    return 'UsuarioJaExisteException(mensagem: $mensagem)';
  }
}
