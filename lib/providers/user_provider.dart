import 'package:accident_identifier/models/user.dart';
import 'package:accident_identifier/services/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StreamProvider<CustomUser>((ref) {
  return UserRepository().user;
});
