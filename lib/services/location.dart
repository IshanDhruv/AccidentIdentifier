import 'dart:async';

import 'package:accident_identifier/data/models/position_item.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  final List<PositionItem> positionItems = <PositionItem>[].obs;
  Stream stream;

  getLocation() async {
    await Geolocator.requestPermission();
    try {
      print("yes");
      stream = Geolocator.getPositionStream();
      stream.listen(
        (position) => positionItems.add(
          PositionItem(position),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  stopGettingLocation() {
    stream = null;
    positionItems.clear();
  }
}
