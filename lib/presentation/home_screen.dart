import 'package:accident_identifier/services/location_controller.dart';
import 'package:app_settings/app_settings.dart';
import 'package:background_location/background_location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocationController _controller = Get.find<LocationController>();

  @override
  void initState() {
    _controller.askForPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Obx(() {
        return ListView(
          children: <Widget>[
            locationData(
                "Latitude: " + _controller.location.latitude.toString()),
            locationData(
                "Longitude: " + _controller.location.longitude.toString()),
            locationData(
                "Altitude: " + _controller.location.altitude.toString()),
            locationData(
                "Accuracy: " + _controller.location.accuracy.toString()),
            locationData("Bearing: " + _controller.location.bearing.toString()),
            locationData("Speed: " + _controller.location.speed.toString()),
            locationData("Time: " + _controller.location.time.toString()),
            RaisedButton(
              child: Text("Start Location Service"),
              onPressed: () async {
                _controller.startLocationService();
              },
            ),
            RaisedButton(
              child: Text("Stop Location Service"),
              onPressed: () {
                _controller.stopLocationService();
              },
            ),
            RaisedButton(
              child: Text("Get Current Location"),
              onPressed: () {
                _controller.getCurrentLocation();
              },
            )
          ],
        );
      }),
    );
  }

  Widget locationData(String data) {
    return Text(
      data,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      textAlign: TextAlign.center,
    );
  }

  @override
  void dispose() {
    _controller.stopLocationService();
    super.dispose();
  }
}
