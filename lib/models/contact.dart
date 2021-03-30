class Contact {
  String id;
  String name;
  String email;
  String relation;
  String phoneNumber;

  Contact({
    this.id,
    this.name,
    this.email,
    this.relation,
    this.phoneNumber,
  });

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }
}
