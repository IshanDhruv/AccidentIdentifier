import 'dart:convert';
import 'dart:io';

import 'package:accident_identifier/models/user.dart';
import 'package:accident_identifier/services/api_response.dart';
import 'package:accident_identifier/services/api_routes.dart';
import 'package:accident_identifier/services/shared_prefs.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<ApiResponse<CustomUser>> getUserDetails() async {
    String token = sharedPreferences.getString('userToken');
    try {
      String url = BaseUrl + UserGroup + UserProfileRoute;
      var response = await http.get(Uri.parse(url), headers: {
        HttpHeaders.authorizationHeader: '$token',
      });
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        return ApiResponse.completed(CustomUser.fromJson(body));
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
