export './login_api.dart';
export './signup_api.dart';

import 'package:dio/dio.dart';
import 'dart:async';
import '../../models/accounts/accounts.dart';
import '../../../keys/keys.dart';




final dio = Dio();

Future<User> getUser(int userID) async {
  final response = await dio.get(
    '${KeyConfig.BASE_URL}accounts/1/'
  );
 if (response.statusCode == 200) {
  return User.fromJson(response.data);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load User');
  }
}
