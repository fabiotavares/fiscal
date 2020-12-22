import 'package:fiscal/app/models/gravidade_model.dart';
import 'package:fiscal/app/repository/gravidade_repository.dart';

class GravidadeService {
  final GravidadeRepository _repository;
  List<GravidadeModel> gravidades;

  GravidadeService(this._repository);

  Future<List<GravidadeModel>> buscarGravidades() async {
    gravidades = await _repository.buscarGravidades();
  }

  GravidadeModel get leve {
    if (gravidades != null) {
      return gravidades.firstWhere((gravidade) => gravidade.id == 'leve');
    }
    return null;
  }

  GravidadeModel get media {
    if (gravidades != null) {
      return gravidades.firstWhere((gravidade) => gravidade.id == 'media');
    }
    return null;
  }

  GravidadeModel get grave {
    if (gravidades != null) {
      return gravidades.firstWhere((gravidade) => gravidade.id == 'grave');
    }
    return null;
  }

  GravidadeModel get gravissima {
    if (gravidades != null) {
      return gravidades.firstWhere((gravidade) => gravidade.id == 'gravissima');
    }
    return null;
  }
}
