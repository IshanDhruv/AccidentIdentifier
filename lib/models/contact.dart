class Contact {
  String id;
  String name;
  String relation;
  String phoneNumber;

  Contact({this.id, this.name, this.relation, this.phoneNumber});

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
  }
}
