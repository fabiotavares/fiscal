import 'package:fiscal/app/shared/auth_store.dart';
import 'package:fiscal/app/shared/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  accountName: Modular.get<AuthStore>().usuarioLogado?.nome != null
                      ? Text(Modular.get<AuthStore>().usuarioLogado.nome)
                      : Text('Inspetor'),
                  accountEmail: Modular.get<AuthStore>().usuarioLogado?.email != null
                      ? Text(Modular.get<AuthStore>().usuarioLogado.email)
                      : Text('Email'),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: Modular.get<AuthStore>().usuarioLogado?.avatar != null
                        ? NetworkImage(Modular.get<AuthStore>().usuarioLogado.avatar)
                        : AssetImage('lib/assets/images/logo.png'),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.account_circle),
                  title: Text('Cadastro'),
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
                  onTap: () async => await Modular.get<AuthStore>().logout(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
