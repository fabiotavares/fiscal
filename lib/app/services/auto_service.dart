import 'package:fiscal/app/models/auto_model.dart';
import 'package:fiscal/app/models/sugestao_model.dart';
import 'package:fiscal/app/repository/auto_repository.dart';

class AutoService {
  final AutoRepository _repository;

  AutoService(this._repository);

  Future<List<AutoModel>> buscarAutos({bool compartilhado = false}) {
    return _repository.buscarAutos(compartilhado: compartilhado);
  }

  Future<String> cadastrarAuto(AutoModel auto) {
    return _repository.cadastrarAuto(auto);
  }

  Future<void> removerAuto(String id) {
    return _repository.removerAuto(id);
  }

  Future<void> atualizarAuto(AutoModel auto) {
    return _repository.atualizarAuto(auto);
  }

  Future<void> compartilharAuto(String id, bool value) {
    return _repository.compartilharAuto(id, value);
  }

  Future<void> clonarAuto(AutoModel auto) {
    return _repository.clonarAuto(auto);
  }

  Future<String> cadastrarSugestao(SugestaoModel sugestao, String idAuto) {
    return _repository.cadastrarSugestao(sugestao, idAuto);
  }

  Future<void> removerSugestao(String id) {
    return _repository.removerSugestao(id);
  }

  Future<void> atualizarSugestao(SugestaoModel sugestao) {
    return _repository.atualizarSugestao(sugestao);
  }
}
