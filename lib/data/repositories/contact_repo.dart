import 'dart:convert';
import 'dart:io';

import 'package:accident_identifier/models/contact.dart';
import 'package:accident_identifier/services/api_response.dart';
import 'package:accident_identifier/services/api_routes.dart';
import 'package:accident_identifier/services/shared_prefs.dart';
import 'package:http/http.dart' as http;

class ContactRepository {
  Future<ApiResponse<List<Contact>>> getContacts() async {
    String token = sharedPreferences.getString('userToken');
    List<Contact> contacts;
    try {
      String url = BaseUrl + ContactGroup;
      var response = await http.get(Uri.parse(url), headers: {
        HttpHeaders.authorizationHeader: '$token',
      });
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        if (body != null) contacts = <Contact>[];
        body.forEach((c) {
          contacts.add(Contact.fromJson(c));
        });
        return ApiResponse.completed(contacts);
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  // Future deleteContact(String id) async {
  //   try {
  //     String url = BaseUrl + ContactGroup + '/' + id;
  //     var response = await http.delete(Uri.parse(url), headers: {
  //       HttpHeaders.authorizationHeader: '$token',
  //     });
  //     if (response.statusCode == 200) {
  //       return true;
  //     } else {
  //       print(response.body);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
