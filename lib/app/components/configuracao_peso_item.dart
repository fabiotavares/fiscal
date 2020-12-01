import 'package:fiscal/app/components/theme_utils.dart';
import 'package:fiscal/app/model/veiculo_peso_model.dart';
import 'package:flutter/material.dart';

import 'package:fiscal/app/modules/peso/peso_controller.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
          Divider(
            thickness: 1,
            height: 20,
          ),
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
    // variável auxiliar
    Widget opcoesRadio;

    if (veiculoModel.valorComprimento1 == veiculoModel.valorComprimento2 || veiculoModel.valorComprimento2 == 0.0) {
      // verifica se há um segundo valor de comprimento para ser exibido
      var limiteComprimento2 = '';
      if (veiculoModel.valorComprimento2 > 0.0) {
        limiteComprimento2 = 'ou ${veiculoModel.limiteComprimento2}';
      }
      // cria apenas um item de rádio para evitar repetição com valores iguais
      opcoesRadio = Container(
        // padding: const EdgeInsets.only(bottom: 8.0),
        child: Observer(builder: (_) {
          return Column(
            children: [
              RadioListTile(
                groupValue: controller.groupPesoPorComprimento,
                onChanged: (value) => controller.changePesoPorComprimento(value),
                value: 0,
                title: Text(
                  '${veiculoModel.pbtc} legal = ${veiculoModel.valorComprimento1} t',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Se comprimento ${veiculoModel.limiteComprimento1} $limiteComprimento2'),
              ),
            ],
          );
        }),
      );
    } else {
      // exibe os dois possíveis valores diferentes
      opcoesRadio = Container(
        // padding: const EdgeInsets.only(bottom: 8.0),
        child: Observer(builder: (_) {
          return Column(children: [
            RadioListTile(
              groupValue: controller.groupPesoPorComprimento,
              onChanged: (value) => controller.changePesoPorComprimento(value),
              value: 0,
              title: Text(
                '${veiculoModel.pbtc} legal = ${veiculoModel.valorComprimento1} t',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Se comprimento ${veiculoModel.limiteComprimento1}'),
            ),
            RadioListTile(
              groupValue: controller.groupPesoPorComprimento,
              onChanged: (value) => controller.changePesoPorComprimento(value),
              value: 1,
              title: Text(
                '${veiculoModel.pbtc} legal = ${veiculoModel.valorComprimento2} t',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Se comprimento ${veiculoModel.limiteComprimento2}'),
            ),
          ]);
        }),
      );
    }

    // retorna uma coluna com os itens montados previamente
    return opcoesRadio;
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
