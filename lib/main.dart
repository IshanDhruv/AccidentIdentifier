import 'package:accident_identifier/services/init_bindings.dart';
import 'package:accident_identifier/services/shared_prefs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/splash_screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitBindings(),
      home: SplashScreen(),
    );
  }
}
