import 'dart:convert';
import 'dart:io';

import 'package:accident_identifier/data/models/contact.dart';
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

  Future<ApiResponse<bool>> addContact(
      String name, String email, String phoneNumber) async {
    try {
      String token = sharedPreferences.getString('userToken');
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
        return ApiResponse.completed(true);
      } else
        print(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<ApiResponse<bool>> deleteContact(String id) async {
    String token = sharedPreferences.getString('userToken');
    try {
      String query = Uri(queryParameters: {'id': id}).query;
      String url = BaseUrl + ContactGroup + '?' + query;
      var response = await http.delete(Uri.parse(url), headers: {
        HttpHeaders.authorizationHeader: '$token',
      });
      if (response.statusCode == 200) {
        return ApiResponse.completed(true);
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<ApiResponse<bool>> notifyContacts() async {
    String token = sharedPreferences.getString('userToken');
    try {
      String url = BaseUrl + NotifyGroup + NotifyContactsRoute;
      var response = await http.get(Uri.parse(url), headers: {
        HttpHeaders.authorizationHeader: '$token',
      });
      if (response.statusCode == 200) {
        return ApiResponse.completed(true);
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
