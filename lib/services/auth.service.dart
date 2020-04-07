import 'package:cantina_honesta/models/login.model.dart';
import 'package:cantina_honesta/responses/login.resposne.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  var token;

  AuthService() {
    print("new AuthService");
  }

  Future getToken() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('token');

    if (data != null) {
      this.token = data;
    }
    return Future.value(token);
  }

  Future logout() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('token', null);

    this.token = null;
    notifyListeners();
    return Future.value(token);
  }

  Future login({String email, String senha}) async {
    try {
      var response = await Dio().post(
          "https://us-central1-cantina-honesta.cloudfunctions.net/api/token",
          data: LoginModel(
            email: email.trim(),
            senha: senha,
          ));
      var data = LoginResponse.fromJson(response.data);
      notifyListeners();
      this.token = data.token;
      return Future.value(data.token);
    } catch (e) {
      this.token = null;
      return Future.value(null);
    }
  }
}
