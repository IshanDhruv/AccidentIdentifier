class CustomUser {
  String id;
  String name;
  String phoneNumber;
  String email;
  List contacts;
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
    contacts = json['notifyContacts'];
    hospitals = json['hospitals'];
  }
}
