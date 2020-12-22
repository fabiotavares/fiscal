// usando o plugin Shered Preferences para armazenar dados não criptografados
import 'dart:convert';

import 'package:fiscal/app/models/gravidade_model.dart';
import 'package:fiscal/app/models/usuario_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// singleton
class SharedPrefsRepository {
  static const _ACCESS_TOKEN = '/_ACCESS_TOKEN/';
  static const _DEVICE_ID = '/_DEVICE_ID/';
  static const _USER_DATA = '/_USER_DATA/';
  static const _GRAVIDADE_LIST = '/_GRAVIDADE_LIST/';

  static SharedPreferences prefs;
  static SharedPrefsRepository _instanceRepository;

  SharedPrefsRepository._();

  static Future<SharedPrefsRepository> get instance async {
    prefs ??= await SharedPreferences.getInstance();
    _instanceRepository ??= SharedPrefsRepository._();
    return _instanceRepository;
  }

  // acesso ao access token
  Future<void> registerAccessToken(String token) async {
    await prefs.setString(_ACCESS_TOKEN, token);
  }

  String get accessToken => prefs.get(_ACCESS_TOKEN);

  // acesso ao device id
  Future<void> registerDeviceId(String deviceId) async {
    await prefs.setString(_DEVICE_ID, deviceId);
  }

  String get deviceId => prefs.get(_DEVICE_ID);

  // acesso ao dados do usuário
  Future<void> registerUserData(UsuarioModel user) async {
    await prefs.setString(_USER_DATA, jsonEncode(user.toJsonFull()));
  }

  UsuarioModel get userData {
    if (prefs.containsKey(_USER_DATA)) {
      Map<String, dynamic> usuarioMapa = jsonDecode(prefs.getString(_USER_DATA));
      return UsuarioModel.fromJson(usuarioMapa);
    }
    return null;
  }

  // acesso à lista de gravidades
  Future<void> registerGravidades(List<GravidadeModel> gravidades) async {
    await prefs.setStringList(_GRAVIDADE_LIST, gravidades.map((g) => jsonEncode(g)).toList());
  }

  List<GravidadeModel> get gravidades {
    if (prefs.containsKey(_GRAVIDADE_LIST)) {
      List<String> gravidadesString = prefs.getStringList(_GRAVIDADE_LIST);
      return gravidadesString.map((g) => GravidadeModel.fromJson(jsonDecode(g))).toList();
    }
    return null;
  }

  void clearUserLocal() {
    print('### entrou em SharedPrefsRepository.clearUserLocal');
    prefs.clear();
  }
}
