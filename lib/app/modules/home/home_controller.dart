import 'package:fiscal/app/models/auto_model.dart';
import 'package:fiscal/app/models/gravidade_model.dart';
import 'package:fiscal/app/models/infracao_model.dart';
import 'package:fiscal/app/services/auto_service.dart';
import 'package:fiscal/app/services/gravidade_service.dart';
import 'package:fiscal/app/services/infracao_service.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final GravidadeService _gravidadeService;
  final InfracaoService _infracaoService;
  final AutoService _autoService;

  _HomeControllerBase(this._gravidadeService, this._infracaoService, this._autoService);

  @observable
  ObservableFuture<List<InfracaoModel>> infracoesFuture;

  @observable
  ObservableFuture<List<AutoModel>> autosUsuarioFuture;

  @observable
  ObservableFuture<List<AutoModel>> autosCompartilhadosFuture;

  @action
  buscarGravidades() async {
    await _gravidadeService.buscarGravidades();
  }

  @action
  buscarInfracoes() {
    infracoesFuture = ObservableFuture(_infracaoService.buscarInfracoes());
  }

  @action
  buscarAutosUsuario() {
    autosUsuarioFuture = ObservableFuture(_autoService.buscarAutos());
  }

  @action
  buscarAutosCompartilhados() {
    autosCompartilhadosFuture = ObservableFuture(_autoService.buscarAutos(compartilhado: true));
  }
}
