import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiscal/app/models/auto_model.dart';
import 'package:fiscal/app/models/sugestao_model.dart';

class AutoRepository {
  Future<List<AutoModel>> buscarAutosUsuario() async {
    final usuario = 'usuario_id'; // temp

    // buscar coleção de autos do usuário no Firebase
    final autos = await FirebaseFirestore.instance.collection('autos').where('usuario', isEqualTo: usuario).get();

    // mapeie cada auto encontrado para um modelo
    final autoModelList = autos.docs.map((auto) {
      if (auto.exists) {
        // buscar as sugestoes do auto
        final model = AutoModel.fromMap(auto.data());
        model.id = auto.id;
        return model;
      }
    }).toList();

    // busque todas as sugestões para cada auto
    await Future.forEach(autoModelList, (autoModel) async {
      final sugestoes =
          await FirebaseFirestore.instance.collection('sugestoes').where('auto', isEqualTo: autoModel.id).get();
      // monta uma lista de SugestaoModel
      final sugestaoModelList = sugestoes.docs.map((sugestao) {
        if (sugestao.exists) {
          final model = SugestaoModel.fromMap(sugestao.data());
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
    // as sugestões não serão cadastradas aqui e deverão ser realizadas individualmente
    final doc = await FirebaseFirestore.instance.collection('autos').add(auto.toMap());
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

  Future<void> atualizarAuto({AutoModel auto}) async {
    // atualiza um documento completo (que já exista no Firebase)
    if (auto.id.isNotEmpty) {
      await FirebaseFirestore.instance.collection('autos').doc(auto.id).set(auto.toMap());
    }
  }

  Future<void> setCompartilhamento(String id, bool value) async {
    // atualiza o campo compartilhado do auto
    if (id.isNotEmpty && value != null) {
      await FirebaseFirestore.instance.collection('autos').doc(id).update({'compartilhado': value});
    }
  }

  Future<void> clonarAuto(AutoModel auto) async {
    // cria um novo objeto igual e cadastro no Firebase
    var model = AutoModel.fromMap(auto.toMap());
    await cadastrarAuto(model);
    // clonar cada sugestão do auto
    Future.forEach(auto.sugestoes, (sugestao) async => await cadastrarSugestao(sugestao, model.id));
  }

  Future<String> cadastrarSugestao(SugestaoModel sugestao, String idAuto) async {
    // adiciona a nova sugestao e atualiza o id do objeto
    final doc = await FirebaseFirestore.instance.collection('sugestoes').add(sugestao.toMap());
    sugestao.id = doc.id;
    return doc.id;
  }

  Future<void> removerSugestao(String id) async {
    // remove a sugestao
    final collection = FirebaseFirestore.instance.collection('sugestoes');
    await collection.doc(id).delete();
  }

  Future<void> atualizarSugestao({SugestaoModel sugestao}) async {
    // atualiza um documento completo (que já exista no Firebase)
    if (sugestao.id.isNotEmpty) {
      await FirebaseFirestore.instance.collection('sugestoes').doc(sugestao.id).set(sugestao.toMap());
    }
  }
}
