import 'dart:convert';
import 'dart:io';

import 'package:accident_identifier/models/contact.dart';
import 'package:accident_identifier/models/hospital.dart';
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

  Future<List<Contact>> getContacts() async {
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
        return contacts;
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future deleteContact(String id) async {
    try {
      String url = BaseUrl + ContactGroup + '/' + id;
      var response = await http.delete(Uri.parse(url), headers: {
        HttpHeaders.authorizationHeader: '$token',
      });
      print(response.body);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        print(body);
        return true;
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future addHospital(
      String name, String email, String phoneNumber, String address) async {
    try {
      String url = BaseUrl + HospitalGroup + AddHospitalRoute;
      var response = await http.post(Uri.parse(url),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
            HttpHeaders.authorizationHeader: '$token',
          },
          body: jsonEncode({
            'name': name,
            'phoneNumber': phoneNumber,
            'email': email,
            'address': address
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

  Future<List<Hospital>> getHospitals() async {
    List<Hospital> hospitals;
    try {
      String url = BaseUrl + HospitalGroup;
      var response = await http.get(Uri.parse(url), headers: {
        HttpHeaders.authorizationHeader: '$token',
      });
      print(response.body);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        if (body != null) hospitals = <Hospital>[];
        body.forEach((c) {
          hospitals.add(Hospital.fromJson(c));
        });
        return hospitals;
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
