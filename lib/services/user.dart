import 'package:accident_identifier/data/repositories/contact_repo.dart';
import 'package:accident_identifier/data/repositories/hospital_repo.dart';
import 'package:accident_identifier/data/repositories/user_repo.dart';
import 'package:accident_identifier/models/contact.dart';
import 'package:accident_identifier/models/hospital.dart';
import 'package:accident_identifier/models/user.dart';
import 'package:accident_identifier/services/api_response.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final _contactRepo = ContactRepository();
  var contactDetailsObs = ApiResponse<List<Contact>>.loading().obs;
  ApiResponse<List<Contact>> get contactDetails => contactDetailsObs.value;
  var contacts = <Contact>[].obs;

  final _hospitalRepo = HospitalRepository();
  var hospitalDetailsObs = ApiResponse<List<Hospital>>.loading().obs;
  ApiResponse<List<Hospital>> get hospitalDetails => hospitalDetailsObs.value;
  var hospitals = <Hospital>[].obs;

  final _userRepo = UserRepository();
  var userDetailsObs = ApiResponse<CustomUser>.loading().obs;
  ApiResponse<CustomUser> get userDetails => userDetailsObs.value;
  var user = CustomUser().obs;

  Future getUserDetails() async {
    final response = await _userRepo.getUserDetails();
    if (response.status == Status.COMPLETED) {
      user.value = response.data;
      update();
    }
    userDetailsObs.value = response;
    update();
  }

  Future getContacts() async {
    final response = await _contactRepo.getContacts();
    if (response.status == Status.COMPLETED) {
      contacts.value = response.data;
      update();
    }
    contactDetailsObs.value = response;
    update();
  }

  Future getHospitals() async {
    final response = await _hospitalRepo.getHospitals();
    if (response.status == Status.COMPLETED) {
      hospitals.value = response.data;
      update();
    }
    hospitalDetailsObs.value = response;
    update();
  }
}
