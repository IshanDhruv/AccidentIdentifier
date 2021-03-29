import 'dart:convert';
import 'dart:io';

import 'package:accident_identifier/models/contact.dart';
import 'package:accident_identifier/models/user.dart';
import 'package:accident_identifier/services/api_routes.dart';
import 'package:accident_identifier/services/shared_prefs.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  CustomUser _user;
  String token = sharedPreferences.getString('userToken');

  Stream<CustomUser> get user async* {
    try {
      await fetchUser();
      print(_user.name);
      yield _user;
    } catch (e) {
      print(e);
    }
  }

  Future fetchUser() async {
    try {
      String url = BaseUrl + UserGroup + UserProfileRoute;
      var response = await http.get(Uri.parse(url), headers: {
        HttpHeaders.authorizationHeader: '$token',
      });
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        _user = CustomUser.fromJson(body);

        return _user;
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future addContact(String name, String email, String phoneNumber) async {
    // _user.contacts.add(Contact(
    // id: "sdsa", name: name, relation: relation, phoneNumber: phoneNumber));
    // print(_user.contacts.length);
    try {
      String url = BaseUrl + ContactGroup + AddContactRoute;
      var response = await http.post(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: '$token',
          },
          body: jsonEncode({
            'name': name,
            'phoneNumber': phoneNumber,
            'email': email,
          }));
      print(response.statusCode);

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        _user = CustomUser.fromJson(body);

        return true;
      } else
        print(response.body);
    } catch (e) {
      print(e);
    }
  }
}
