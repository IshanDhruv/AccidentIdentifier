import 'dart:convert';
import 'dart:io';

import 'package:accident_identifier/models/user.dart';
import 'package:accident_identifier/services/api_routes.dart';
import 'package:accident_identifier/services/shared_prefs.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  CustomUser _user;

  Stream<CustomUser> get user async* {
    try {
      String url = BaseUrl + UserGroup + UserProfileRoute;
      String token = sharedPreferences.getString('userToken');
      var response = await http.get(Uri.parse(url), headers: {
        HttpHeaders.authorizationHeader: '$token',
      });
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        _user = CustomUser.fromJson(body);
        yield _user;
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
