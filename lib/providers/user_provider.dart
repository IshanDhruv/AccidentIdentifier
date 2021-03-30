import 'package:accident_identifier/models/contact.dart';
import 'package:accident_identifier/models/hospital.dart';
import 'package:accident_identifier/models/user.dart';
import 'package:accident_identifier/services/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userServicesProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

final userProvider = StreamProvider<CustomUser>((ref) {
  return ref.watch(userServicesProvider).user;
});

final contactsProvider = StreamProvider<List<Contact>>((ref) {
  return ref.watch(userServicesProvider).getContacts().asStream();
});

final hospitalsProvider = StreamProvider<List<Hospital>>((ref) {
  return ref.watch(userServicesProvider).getHospitals().asStream();
});
