import 'package:fiscal/app/models/gravidade_model.dart';
import 'package:fiscal/app/repository/gravidade_repository.dart';
import 'package:fiscal/app/repository/shared_prefs_repository.dart';

class GravidadeService {
  final GravidadeRepository _repository;

  GravidadeService(this._repository);

  Future<List<GravidadeModel>> _buscarGravidadesOnline() {
    return _repository.buscarGravidades();
  }

  Future<List<GravidadeModel>> buscarGravidades() async {
    // verifica primeiro se a lista de gravidades está disponível offline
    final prefs = await SharedPrefsRepository.instance;
    var res = prefs.gravidades;
    if (res != null) {
      return res;
    }

    // caso contrário, busque online e armazene localmente
    res = await _buscarGravidadesOnline();
    if (res != null) {
      prefs.registerGravidades(res);
    }
    return res;
  }

  Future<void> updateGravidades() async {
    // força nova busca online e armazenamento local
    final prefs = await SharedPrefsRepository.instance;
    final res = await _repository.buscarGravidades();
    if (res != null) {
      prefs.registerGravidades(res);
    }
  }
}
