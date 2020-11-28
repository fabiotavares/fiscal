import 'package:fiscal/app/components/theme_utils.dart';
import 'package:fiscal/app/model/veiculo_peso_model.dart';
import 'package:flutter/material.dart';

import 'package:fiscal/app/modules/peso/peso_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfiguracaoPesoItem extends StatelessWidget {
  // controller pode ser nulo, indicando exibição apenas para leitura
  final VeiculoPesoModel veiculoModel;
  final PesoController controller;

  const ConfiguracaoPesoItem({
    Key key,
    @required this.veiculoModel,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(6),
            margin: EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: ThemeUtils.accentColor,
            ),
            child: Text(veiculoModel.id, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          SizedBox(height: 5),
          Text(
            veiculoModel.tipo,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          // SizedBox(height: 5),
          Divider(thickness: 1),
          Image.asset('assets/images/${veiculoModel.id}a.png'),
          Image.asset('assets/images/${veiculoModel.id}b.png'),
          SizedBox(height: 5),
          Text(
            'Comprimento máximo: ${veiculoModel.comprimentoMaximo}',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          ),
          Text(
            veiculoModel.limiteEixos,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 14),
          ),
          SizedBox(height: 5),
          Divider(thickness: 1),
          controller != null ? showRadioOptions() : showReadOnly(),
          if (veiculoModel.obs != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                veiculoModel.obs,
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            )
        ],
      ),
    );
  }

  Widget showRadioOptions() {
    return Observer(builder: (_) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Radio(
                value: 0,
                groupValue: controller.groupPesoPorComprimento,
                onChanged: (value) => controller.changePesoPorComprimento(value),
              ),
              Text(
                '${veiculoModel.valorComprimento1}t se ${veiculoModel.limiteComprimento1}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          if (veiculoModel.valorComprimento2 > 0)
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: controller.groupPesoPorComprimento,
                  onChanged: (value) => controller.changePesoPorComprimento(value),
                ),
                Text(
                  '${veiculoModel.valorComprimento2}t se ${veiculoModel.limiteComprimento2}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                )
              ],
            ),
        ],
      );
    });
  }

  Widget showReadOnly() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '${veiculoModel.valorComprimento1}t se ${veiculoModel.limiteComprimento1}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          if (veiculoModel.valorComprimento2 > 0)
            Text(
              '${veiculoModel.valorComprimento2}t se ${veiculoModel.limiteComprimento2}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
        ],
      ),
    );
  }
}
