import 'dart:convert';
import 'dart:io';

import 'package:accident_identifier/services/api_routes.dart';
import 'package:accident_identifier/services/shared_prefs.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<String> get userToken async {
    String _userToken = sharedPreferences.getString('userToken');
    return _userToken;
  }

  Future signUp(
      String name, String email, String phoneNumber, String password) async {
    String url = BaseUrl + UserGroup + UserSignUpRoute;
    String notifToken = sharedPreferences.getString('notifToken');
    var response = await http.post(Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode({
          'name': name,
          'number': '+91' + phoneNumber,
          'password': password,
          'email': email,
          "deviceToken": notifToken
        }));
    print(response.statusCode);

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      sharedPreferences.setString('userToken', body['token']);
      return true;
    } else
      print(response.body);
  }

  Future signIn(String email, String password) async {
    String url = BaseUrl + UserGroup + UserSignInRoute;
    String notifToken = sharedPreferences.getString('notifToken');
    var response = await http.post(Uri.parse(url),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
        body: jsonEncode(
            {'email': email, 'password': password, "deviceToken": notifToken}));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      sharedPreferences.setString('userToken', body['token']);
      return true;
    } else
      print(response.body);
  }

  Future signOut() async {
    String url = BaseUrl + UserGroup + UserSignOutAllRoute;
    String token = sharedPreferences.getString('userToken');
    var response = await http.get(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: '$token',
      },
    );
    if (response.statusCode == 200) {
      sharedPreferences.remove('userToken');
      return true;
    }
  }
}
