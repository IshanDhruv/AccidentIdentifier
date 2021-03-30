class Hospital {
  String id;
  String name;
  String phoneNumber;
  String location;

  Hospital({this.id, this.name, this.phoneNumber, this.location});

  Hospital.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    location = json['address'];
    phoneNumber = json['phoneNumber'];
  }
}
