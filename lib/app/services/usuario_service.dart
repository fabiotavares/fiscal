import 'package:fiscal/app/core/exceptions/acesso_negado_dio_exceptions.dart';
import 'package:fiscal/app/core/exceptions/acesso_negado_firebase_exceptions.dart';
import 'package:fiscal/app/models/usuario_model.dart';
import 'package:fiscal/app/repository/shared_prefs_repository.dart';
import 'package:fiscal/app/repository/usuario_repository.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UsuarioService {
  final UsuarioRepository _repository;

  UsuarioService(this._repository);

  Future<void> login({
    @required bool facebookLogin,
    String email,
    String senha,
  }) async {
    try {
      UsuarioModel user = await _repository.login(email, senha: senha, facebookLogin: facebookLogin);

      if (user.token == null) {
        throw AcessoNegadoFirebaseException('Acesso Negado');
      }

      // verifica necessidade de cadastrar no banco de dados (Firestore)
      // await _repository.cadastrarUsuarioBanco(user);

      // salva dados do usuário logado localmente
      final prefs = await SharedPrefsRepository.instance;
      await prefs.registerUserData(user);
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
      final user = await _repository.cadastrarUsuarioFireAuth(email: email, senha: senha);
      // cadastrar usuário no firebase store e salva localmente
      // await _repository.cadastrarUsuarioBanco(user);
      await _repository.salvaUsuarioLocal(user);
      //
    } catch (e) {
      print('Erro ao cadastrar usuário: $e');
      rethrow;
    }
  }

  Future<void> salvaUsuarioLocal(UsuarioModel user) async {
    await _repository.salvaUsuarioLocal(user);
  }

  Future<UsuarioModel> recuperaDadosUsuarioLogado() async {
    final prefs = await SharedPrefsRepository.instance;
    return prefs.userData;
  }

  Future<void> logout() async {
    // desloga do FireAuth
    await _repository.logoutFireAuth();
    // limpa dados internos e volta para tela de login
    final prefs = await SharedPrefsRepository.instance;
    prefs.logout();
  }
}
