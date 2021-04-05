import 'package:accident_identifier/data/models/user.dart';
import 'package:accident_identifier/services/api_response.dart';
import 'package:accident_identifier/services/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserController _controller = Get.find<UserController>();

  @override
  void initState() {
    _controller.getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: Obx(() {
      switch (_controller.userDetails.status) {
        case Status.INIT:
          break;
        case Status.LOADING:
          return Center(child: CircularProgressIndicator());
          break;
        case Status.ERROR:
          debugPrint(_controller.userDetails.message);
          return Center(
            child: Container(
              margin: EdgeInsets.all(32),
              child: Text(
                _controller.userDetails.message,
                textAlign: TextAlign.center,
              ),
            ),
          );
          break;
        case Status.COMPLETED:
          return _userProfile(_controller.user.value);
          break;
      }
      return Container();
    }));
  }

  Widget _userProfile(CustomUser user) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 80),
          Container(),
          Text(user.name),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
