import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiscal/app/models/auto_model.dart';
import 'package:fiscal/app/models/infracao_model.dart';
import 'package:fiscal/app/models/sugestao_model.dart';
import 'package:fiscal/app/shared/auth_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AutoRepository {
  Future<List<AutoModel>> buscarAutos({bool compartilhado = false}) async {
    // buscar coleção de autos compartilhados no Firebase
    // se compartilhado for false, busca apenas autos do usuário logado
    QuerySnapshot autos;
    if (compartilhado) {
      autos = await FirebaseFirestore.instance.collection('autos').where('compartilhado', isEqualTo: true).get();
    } else {
      // obtém os dados do usuário logado...
      final usuario = Modular.get<AuthStore>().fireUser.uid;
      autos = await FirebaseFirestore.instance.collection('autos').where('usuario', isEqualTo: usuario).get();
    }

    // mapeie cada auto encontrado para um modelo
    final autoModelList = autos.docs.map((auto) {
      if (auto.exists) {
        final model = AutoModel.fromJson(auto.data());
        model.id = auto.id;
        return model;
      }
    }).toList();

    // busque os dados da infração e todas as sugestões de cada auto
    await Future.forEach(autoModelList, (AutoModel autoModel) async {
      // buscando os dados da infração do auto
      final infracao = await FirebaseFirestore.instance.collection('infracoes').doc(autoModel.infracao.id).get();
      if (infracao.exists) {
        autoModel.infracao = InfracaoModel.fromJson(infracao.data());
      }
      // buscando as sugestões do auto
      final sugestoes =
          await FirebaseFirestore.instance.collection('sugestoes').where('auto', isEqualTo: autoModel.id).get();
      // monta uma lista de SugestaoModel
      final sugestaoModelList = sugestoes.docs.map((sugestao) {
        if (sugestao.exists) {
          final model = SugestaoModel.fromJson(sugestao.data());
          model.id = sugestao.id;
          return model;
        }
      }).toList();
      // atualiza a lista de sugestões do auto em questão
      autoModel.sugestoes = sugestaoModelList;
    });

    return autoModelList;
  }

  Future<String> cadastrarAuto(AutoModel auto) async {
    // adiciona o novo auto e atualiza o id do auto
    // as sugestões serão cadastradas individualmente pelo usuário posteriromente
    final doc = await FirebaseFirestore.instance.collection('autos').add(auto.toJson());
    auto.id = doc.id;

    return doc.id;
  }

  Future<void> removerAuto(String id) async {
    // remove todas as sugestões do auto
    final sugestoes = await FirebaseFirestore.instance.collection('sugestoes').where('auto', isEqualTo: id).get();
    await Future.forEach(sugestoes.docs, (sugestao) => sugestao.reference.delete());
    // remove o auto
    final collection = FirebaseFirestore.instance.collection('autos');
    await collection.doc(id).delete();
  }

  Future<void> atualizarAuto(AutoModel auto) async {
    // atualiza um documento completo (que já exista no Firebase)
    if (auto.id.isNotEmpty) {
      await FirebaseFirestore.instance.collection('autos').doc(auto.id).set(auto.toJson());
    }
  }

  Future<void> compartilharAuto(String id, bool value) async {
    // atualiza o campo compartilhado do auto
    if (id.isNotEmpty && value != null) {
      await FirebaseFirestore.instance.collection('autos').doc(id).update({'compartilhado': value});
    }
  }

  Future<void> clonarAuto(AutoModel auto) async {
    // cria um novo objeto igual e cadastro no Firebase
    var model = AutoModel.fromJson(auto.toJson());
    await cadastrarAuto(model);
    // clonar cada sugestão do auto
    Future.forEach(auto.sugestoes, (sugestao) async => await cadastrarSugestao(sugestao, model.id));
  }

  Future<String> cadastrarSugestao(SugestaoModel sugestao, String idAuto) async {
    // adiciona a nova sugestao e atualiza o id do objeto
    final doc = await FirebaseFirestore.instance.collection('sugestoes').add(sugestao.toJson());
    sugestao.id = doc.id;
    return doc.id;
  }

  Future<void> removerSugestao(String id) async {
    // remove a sugestao
    final collection = FirebaseFirestore.instance.collection('sugestoes');
    await collection.doc(id).delete();
  }

  Future<void> atualizarSugestao(SugestaoModel sugestao) async {
    // atualiza um documento completo (que já exista no Firebase)
    if (sugestao.id.isNotEmpty) {
      await FirebaseFirestore.instance.collection('sugestoes').doc(sugestao.id).set(sugestao.toJson());
    }
  }
}
