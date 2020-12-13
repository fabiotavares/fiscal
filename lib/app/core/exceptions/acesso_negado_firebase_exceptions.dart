class AcessoNegadoFirebaseException implements Exception {
  String mensagem;

  AcessoNegadoFirebaseException(String mensagem) {
    print('Erro inesperado: $mensagem');
    switch (mensagem.toUpperCase()) {
      case "INVALID-EMAIL":
        this.mensagem = 'Seu email não parece ter o formato correto.';
        break;
      case "WRONG-PASSWORD":
        this.mensagem = 'Senha incorreta.';
        break;
      case "USER-NOT-FOUND":
        this.mensagem = 'Não existe usuário com este email.';
        break;
      case "USER-DISABLED":
        this.mensagem = 'Usuário com este email está desativado';
        break;
      case "TOO-MANY-REQUESTS":
        this.mensagem = 'Muitas tentativas sem sucesso. Tente mais tarde.';
        break;
      case "OPERATION-NOT-ALLOWED":
        this.mensagem = 'Login com email e senha não está ativado.';
        break;
      case "ACESSO NEGADO":
        this.mensagem = 'Acesso negado.';
        break;
      case "ACCOUNT-EXISTS-WITH-DIFFERENT-CREDENTIAL":
        this.mensagem = 'Esta conta exige email e senha.';
        break;
      default:
        this.mensagem = 'Um erro inesperado aconteceu.';
    }
  }

  @override
  String toString() {
    return 'AcessoNegadoFirebaseException(mensagem: $mensagem)';
  }
}
