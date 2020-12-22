import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiscal/app/models/infracao_model.dart';

class InfracaoRepository {
  Future<List<InfracaoModel>> buscarInfracoes() async {
    // buscar coleção infracoes no Firebase
    final infracoes = await FirebaseFirestore.instance.collection('infracoes').get();

    // mapeie cada infracao encontrada para um modelo
    return infracoes.docs.map((g) {
      if (g.exists) {
        final model = InfracaoModel.fromJson(g.data());
        model.id = g.id;
        return model;
      }
    }).toList();
  }

  Future<String> cadastrarInfracao(InfracaoModel infracao) async {
    final doc = await FirebaseFirestore.instance.collection('infracoes').add(infracao.toJson());
    infracao.id = doc.id;

    return doc.id;
  }

  Future<void> removerInfracao(String id) async {
    final collection = FirebaseFirestore.instance.collection('infracoes');
    await collection.doc(id).delete();
  }

  Future<void> atualizarInfracao(InfracaoModel infracao) async {
    if (infracao.id.isNotEmpty) {
      await FirebaseFirestore.instance.collection('infracoes').doc(infracao.id).set(infracao.toJson());
    }
  }
}
