import 'package:accident_identifier/models/contact.dart';

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
    // if (json['notifyContacts'] != null) {
    //   contacts = <Contact>[];
    //   json['notifyContacts'].forEach((c) {
    //     contacts.add(Contact.fromJson(c));
    //   });
    // }
    hospitals = json['hospitals'];
  }
}
