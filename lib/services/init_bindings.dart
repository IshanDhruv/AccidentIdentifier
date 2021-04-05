import 'package:accident_identifier/services/controllers/location_controller.dart';
import 'package:accident_identifier/services/controllers/user_controller.dart';
import 'package:get/get.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController(), permanent: true);
    Get.put(LocationController(), permanent: true);
  }
}
