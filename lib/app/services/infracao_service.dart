import 'package:fiscal/app/models/infracao_model.dart';
import 'package:fiscal/app/repository/infracao_repository.dart';

class InfracaoService {
  final InfracaoRepository _repository;

  InfracaoService(this._repository);

  Future<List<InfracaoModel>> buscarInfracoes() {
    return _repository.buscarInfracoes();
  }

  Future<String> cadastrarInfracao(InfracaoModel infracao) {
    return _repository.cadastrarInfracao(infracao);
  }

  Future<void> removerAuto(String id) {
    return _repository.removerInfracao(id);
  }

  Future<void> atualizarAuto(InfracaoModel infracao) {
    return _repository.atualizarInfracao(infracao);
  }
}
