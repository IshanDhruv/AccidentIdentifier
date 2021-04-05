import 'package:background_location/background_location.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  var locationObs = Location().obs;
  Location get location => locationObs.value;
  var permission = true.obs;

  askForPermissions() async {
    await BackgroundLocation.getPermissions(
      onGranted: () {
        permission.value = true;
      },
      onDenied: () {
        permission.value = false;
      },
    );
  }

  startLocationService() async {
    await BackgroundLocation.setAndroidNotification(
      title: "Background service is running",
      message: "Background location in progress",
      icon: "@mipmap/ic_launcher",
    );
    await BackgroundLocation.setAndroidConfiguration(1000);
    await BackgroundLocation.startLocationService();
    BackgroundLocation.getLocationUpdates((location) {
      this.locationObs.value = location;
    });
  }

  stopLocationService() async {
    BackgroundLocation.stopLocationService();
  }

  getCurrentLocation() async {
    BackgroundLocation().getCurrentLocation().then((location) {
      print("This is current Location " + location.toMap().toString());
    });
  }
}
