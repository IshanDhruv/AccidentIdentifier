import 'package:accident_identifier/services/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServicesProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authStateProvider = StreamProvider<String>((ref) {
  return ref.watch(authServicesProvider).userToken.asStream();
});
