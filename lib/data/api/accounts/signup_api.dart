import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/dio_config.dart';



class SignUpStateNotifier extends StateNotifier<Map<String,dynamic>> {
  final Ref ref;
  SignUpStateNotifier(this.ref):super({});
  Future <void> signup(body) async{
    final dio= ref.watch(dioProvider);
    final response = await dio.post(
      'accounts/',
      options: Options(
        headers: {
          Headers.contentTypeHeader: 'application/json',
        }
      ),
      data: jsonEncode(body),
      );
    if (response.statusCode==200) {
      return response.data;
    }
    else{
      throw Exception('SignUp Failed');
    }

  }


}


final signUpProvider = StateNotifierProvider<SignUpStateNotifier, Map<String,dynamic>>((ref) {

return SignUpStateNotifier(ref);
}
);









