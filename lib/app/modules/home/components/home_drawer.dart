import 'package:cached_network_image/cached_network_image.dart';
import 'package:fiscal/app/shared/auth_store.dart';
import 'package:fiscal/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authStore = Modular.get<AuthStore>();
    return Drawer(
      child: Container(
        child: Observer(
          builder: (BuildContext context) {
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: ThemeUtils.accentColor,
                  ),
                  accountName:
                      authStore.usuarioLogado?.nome != null ? Text(authStore.usuarioLogado.nome) : Text('Inspetor'),
                  accountEmail:
                      authStore.usuarioLogado?.email != null ? Text(authStore.usuarioLogado.email) : Text('Email'),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: authStore.usuarioLogado?.avatar != null
                        ? (authStore.usuarioLogado.avatar == '@'
                            ? AssetImage('lib/assets/images/user.jpg')
                            // : NetworkImage(authStore.usuarioLogado.avatar))
                            : CachedNetworkImageProvider(authStore.usuarioLogado.avatar))
                        : AssetImage('lib/assets/images/user.jpg'),
                    onBackgroundImageError: (exception, stackTrace) {},
                  ),
                ),
                InkWell(
                  child: ListTile(
                    leading: Icon(Icons.account_circle),
                    title: Text('Cadastro'),
                  ),
                  onTap: () async {
                    if (authStore.usuarioLogado != null) {
                      Modular.to.pushNamed('/home/usuario');
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('Mensagens'),
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Configurações'),
                ),
                ListTile(
                  leading: Icon(MaterialCommunityIcons.shield_account),
                  title: Text('Privacidade'),
                ),
                Divider(),
                InkWell(
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Sair'),
                  ),
                  onTap: () async => await authStore.logout(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
