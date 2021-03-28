import 'package:accident_identifier/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth/authenticate.dart';
import 'base_screen.dart';

class SplashScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _authState = watch(authStateProvider);
    return _authState.when(
      data: (value) {
        if (value != null)
          return BaseScreen();
        else
          return Authenticate();
      },
      loading: () {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
      error: (error, stackTrace) {
        return Scaffold(
          body: Center(
            child: Text("Something went wrong. :("),
          ),
        );
      },
    );
  }
}
