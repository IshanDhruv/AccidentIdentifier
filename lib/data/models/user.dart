import 'package:accident_identifier/data/models/contact.dart';

class CustomUser {
  String id;
  String name;
  String phoneNumber;
  String email;
  List<Contact> contacts;
  List hospitals;

  CustomUser(
      {this.id,
      this.name,
      this.phoneNumber,
      this.email,
      this.contacts,
      this.hospitals});

  CustomUser.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    phoneNumber = json['number'];
    email = json['email'];
    hospitals = json['hospitals'];
  }
}
