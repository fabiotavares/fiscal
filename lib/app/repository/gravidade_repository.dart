import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fiscal/app/models/gravidade_model.dart';

class GravidadeRepository {
  Future<List<GravidadeModel>> buscarGravidades() async {
    // buscar coleção gravidades no Firebase
    final gravidades = await FirebaseFirestore.instance.collection('gravidades').get();

    // mapeie cada gravidade encontrada para um modelo
    return gravidades.docs.map((g) {
      if (g.exists) {
        final model = GravidadeModel.fromJson(g.data());
        model.id = g.id;
        return model;
      }
    }).toList();
  }
}
