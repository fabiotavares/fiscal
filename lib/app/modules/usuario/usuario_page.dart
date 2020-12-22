import 'package:cached_network_image/cached_network_image.dart';
import 'package:fiscal/app/shared/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'usuario_controller.dart';

class UsuarioPage extends StatefulWidget {
  final String title;
  const UsuarioPage({Key key, this.title = "Cadastro"}) : super(key: key);

  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends ModularState<UsuarioPage, UsuarioController> {
  //use 'controller' variable to access controller

  @override
  void initState() {
    super.initState();
    // inicia os campos com os dados do usuário logado
    final user = Modular.get<AuthStore>().usuarioLogado;
    controller.avatarController.text = user.avatar == '@' ? '' : user.avatar;
    controller.nomeController.text = user.nome;
    // adiciona um ouvinte para controlar a exibição do avatar
    controller.avatarController.addListener(() {
      // considera a url sempre válida, deixando para o componente dizer o contrário
      controller.setUrlValida(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // confirma com o usuário de deseja descartar a fiscalização atual
        // var resposta = await YesNoDialog.show(
        //   title: 'Atenção',
        //   context: context,
        //   msg: 'Deseja descartar a fiscalização atual e voltar pra tela inicial?',
        // );
        // return resposta;
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: () {
                controller.atualizarProfile();
              },
            )
          ],
        ),
        body: Observer(builder: (_) {
          return Container(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: controller.urlValida && controller.avatarController.text != ''
                            ? CachedNetworkImageProvider(controller.avatarController.text)
                            : AssetImage('lib/assets/images/user.jpg'),
                        onBackgroundImageError: (exception, stackTrace) {
                          // retira os possíveis espaços colocados pelo usuário
                          if (controller.avatarController.text.trim().isNotEmpty) {
                            // se não está vazia e caiu neste erro, então não é uma url válida
                            controller.setUrlValida(false);
                          }
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: controller.avatarController,
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          labelText: 'URL para imagem',
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                        validator: (value) {
                          if (!controller.urlValida) {
                            return 'Informe uma URL válida!';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: controller.nomeController,
                        textCapitalization: TextCapitalization.words,
                        decoration: const InputDecoration(
                          labelText: 'Nome para exibição',
                          labelStyle: TextStyle(fontSize: 14),
                        ),
                        validator: (value) {
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
