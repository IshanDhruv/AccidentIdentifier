import 'package:accident_identifier/models/user.dart';
import 'package:accident_identifier/services/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userServicesProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

final userProvider = StreamProvider<CustomUser>((ref) {
  return ref.watch(userServicesProvider).user;
});
