import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LocationPermission locationPermission;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final List<_PositionItem> _positionItems = <_PositionItem>[];
  StreamSubscription<Position> _positionStreamSubscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldMessengerKey,
      body: FutureBuilder<LocationPermission>(
        future: Geolocator.requestPermission(),
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
          if (_positionItems.isNotEmpty) {
            final positionItem = _positionItems.last;
            if (positionItem.type == _PositionItemType.permission) {
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
                      _positionItems.add(
                        _PositionItem(
                          _PositionItemType.position,
                          value.toString(),
                        ),
                      )
                    },
                  );
                },
                label: Text("Current Position")),
          ),
          Positioned(
            bottom: 80.0,
            right: 10.0,
            child: FloatingActionButton.extended(
              onPressed: _toggleListening,
              label: Text(() {
                if (_positionStreamSubscription == null) {
                  return "Start stream";
                } else {
                  final buttonText =
                      _positionStreamSubscription.isPaused ? "Resume" : "Pause";
                  return "$buttonText stream";
                }
              }()),
              backgroundColor: _determineButtonColor(),
            ),
          ),
        ],
      ),
    );
  }

  bool _isListening() => !(_positionStreamSubscription == null ||
      _positionStreamSubscription.isPaused);

  Color _determineButtonColor() {
    return _isListening() ? Colors.green : Colors.red;
  }

  void _toggleListening() {
    if (_positionStreamSubscription == null) {
      final positionStream = Geolocator.getPositionStream();
      _positionStreamSubscription = positionStream.handleError((error) {
        _positionStreamSubscription?.cancel();
        _positionStreamSubscription = null;
      }).listen((position) => setState(() => _positionItems.add(
          _PositionItem(_PositionItemType.position, position.toString()))));
      _positionStreamSubscription?.pause();
    }

    setState(() {
      if (_positionStreamSubscription == null) {
        return;
      }

      if (_positionStreamSubscription.isPaused) {
        _positionStreamSubscription.resume();
      } else {
        _positionStreamSubscription.pause();
      }
    });
  }

  @override
  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription.cancel();
      _positionStreamSubscription = null;
    }

    super.dispose();
  }
}

enum _PositionItemType {
  permission,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}
