import 'package:accident_identifier/services/user.dart';
import 'package:get/get.dart';

class InitBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController(), permanent: true);
  }
}
