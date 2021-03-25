import 'package:accident_identifier/models/user.dart';
import 'package:accident_identifier/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServicesProvider = Provider<Auth>((ref) {
  return Auth();
});

final authStateProvider = StreamProvider<User>((ref) {
  return ref.watch(authServicesProvider).authStateChange;
});

final userProvider = StreamProvider<CustomUser>((ref) {
  return Auth().user;
});
