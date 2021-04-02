import 'dart:convert';
import 'dart:io';

import 'package:accident_identifier/data/models/hospital.dart';
import 'package:accident_identifier/services/api_response.dart';
import 'package:accident_identifier/services/api_routes.dart';
import 'package:accident_identifier/services/shared_prefs.dart';
import 'package:http/http.dart' as http;

class HospitalRepository {
  Future<ApiResponse<List<Hospital>>> getHospitals() async {
    String token = sharedPreferences.getString('userToken');
    List<Hospital> hospitals;
    try {
      String url = BaseUrl + HospitalGroup;
      var response = await http.get(Uri.parse(url), headers: {
        HttpHeaders.authorizationHeader: '$token',
      });
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        if (body != null) hospitals = <Hospital>[];
        body.forEach((c) {
          hospitals.add(Hospital.fromJson(c));
        });
        return ApiResponse.completed(hospitals);
      } else {
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<ApiResponse<bool>> addHospital(
      String name, String email, String phoneNumber, String address) async {
    try {
      String token = sharedPreferences.getString('userToken');
      String url = BaseUrl + HospitalGroup + AddContactRoute;
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
        return ApiResponse.completed(true);
      } else
        print(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<ApiResponse<bool>> deleteHospital(String id) async {
    String token = sharedPreferences.getString('userToken');
    try {
      String query = Uri(queryParameters: {'id': id}).query;
      String url = BaseUrl + HospitalGroup + '?' + query;
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
}
