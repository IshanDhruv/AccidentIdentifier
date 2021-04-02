import 'dart:async';

import 'package:accident_identifier/data/models/position_item.dart';
import 'package:accident_identifier/services/location.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocationPermission locationPermission;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  LocationController _controller = Get.find<LocationController>();

  @override
  void initState() {
    _controller.getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldMessengerKey,
      body: FutureBuilder(
        future: _controller.getLocation(),
        builder: (context, snapshot) {
          locationPermission = snapshot.data;
          if (locationPermission == LocationPermission.deniedForever) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: const Text(
                    'You have permanently denied location settings. Please got to your apps settings and enable it for the app to work.'),
                duration: const Duration(seconds: 5),
                action: SnackBarAction(
                  label: 'ENABLE',
                  onPressed: () => AppSettings.openAppSettings(),
                ),
              ));
            });
            return Container();
          }

          return Obx(() {
            if (_controller.positionItems.isNotEmpty) {
              final positionItem = _controller.positionItems.last;
              if (positionItem.type == PositionItemType.permission) {
                return ListTile(
                  title: Text(positionItem.displayValue,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                );
              } else {
                return Card(
                  child: ListTile(
                    title: Text(
                      positionItem.displayValue,
                    ),
                  ),
                );
              }
            } else
              return Container();
          });
        },
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: FloatingActionButton.extended(
                onPressed: () async {
                  await Geolocator.getCurrentPosition().then(
                    (value) => {
                      _controller.positionItems.add(
                        PositionItem(
                          PositionItemType.position,
                          value.toString(),
                        ),
                      )
                    },
                  );
                },
                label: Text("Current Position")),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.stopGettingLocation();
    super.dispose();
  }
}
