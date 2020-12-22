import 'package:fiscal/app/core/exceptions/acesso_negado_dio_exceptions.dart';
import 'package:fiscal/app/core/exceptions/acesso_negado_firebase_exceptions.dart';
import 'package:fiscal/app/repository/shared_prefs_repository.dart';
import 'package:fiscal/app/repository/usuario_repository.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fiscal/app/shared/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UsuarioService {
  final UsuarioRepository _repository;

  UsuarioService(this._repository);

  Future<void> login({
    @required bool facebookLogin,
    String email,
    String senha,
  }) async {
    try {
      // chama o login do repository
      final token = await _repository.login(email, senha: senha, facebookLogin: facebookLogin);
      // se o token resultante for nulo, o acesso é negado
      if (token == null) {
        throw AcessoNegadoFirebaseException('Acesso Negado');
      }
      // salva dados do usuário logado localmente
      final authStore = Modular.get<AuthStore>();
      authStore.updateUsuarioLogado();
      //
    } on PlatformException catch (e) {
      // erro específico do firebase
      // repassando a excessão, pois é a controller que informará na tela
      print('Erro ao fazer login no Firebase $e');
      print('erro #01');
      rethrow;
    } on DioError catch (e) {
      // erro específico do Dio
      print('erro #02');
      if (e.response.statusCode == 403) {
        // envia exceção customizada
        throw AcessoNegadoDioException(e.response.data['message'], exception: e);
      } else {
        print('erro #03');
        rethrow;
      }
    } on FirebaseAuthException catch (e) {
      print('*** Erro Login Firebase: ${e.code}');
      throw AcessoNegadoFirebaseException(e.code);
    } catch (e) {
      // repassando a excessão, pois é a controller que informará na tela
      print('Erro ao fazer login $e');
      print('erro #04');
      rethrow;
    }
  }

  Future<void> cadastrarUsuario(String email, String senha) async {
    try {
      // cadastra usuário no fire auth
      final token = await _repository.cadastrarUsuarioFireAuth(email: email, senha: senha);
      // se o token resultante for nulo, o acesso é negado
      if (token == null) {
        throw AcessoNegadoFirebaseException('Acesso Negado');
      }
      // salva dados do usuário logado localmente
      final authStore = Modular.get<AuthStore>();
      authStore.updateUsuarioLogado();
      //
    } catch (e) {
      print('Erro ao cadastrar usuário: $e');
      rethrow;
    }
  }

  Future<void> atualizarProfile({String displayName, String photoURL}) async {
    try {
      // atualiza dados de profile do usuário
      await _repository.atualizarProfile(displayName: displayName, photoURL: photoURL);
      // atualiza dados do usuário logado localmente
      final authStore = Modular.get<AuthStore>();
      authStore.updateUsuarioLogado();
      //
    } catch (e) {
      print('Erro ao atualizar dados de profile do usuário: $e');
      rethrow;
    }
  }

  Future<void> logout() async {
    // desloga do FireAuth
    try {
      await _repository.logoutFireAuth();
      // limpa dados internos
      final prefs = await SharedPrefsRepository.instance;
      prefs.clearUserLocal();
    } finally {
      // redireciona para a home (mesme que ocorra uma excessão no processo)
      Modular.to.pushNamedAndRemoveUntil('/', ModalRoute.withName('/'));
    }
  }
}
