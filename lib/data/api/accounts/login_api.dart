import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../data/models/accounts/accounts.dart';
import '../config/dio_config.dart';
import '../../../main.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';



class AuthStateNotifier extends StateNotifier<Token> {
  final Ref ref;
  AuthStateNotifier(this.ref):super(Token(refresh: '', access: ''));
  Future <void> login(body) async{
    final dio= ref.watch(dioProvider);
    final response = await dio.post(
      'token/',
      options: Options(
        headers: {
          Headers.contentTypeHeader: 'application/json',
        }
      ),
      data: jsonEncode(body),
      );
    if (response.statusCode==200) {
      // print(response.data);
      storeToken('access',response.data['access']);
      storeToken('refresh',response.data['refresh']);
      // final state=Token(refresh:response.data['refresh'], access:response.data['access']);
      // print(state.toJson());
    }
    else{
      throw Exception('Login Failed');
    }

  }

  static void storeToken(String key,String token) async{
      await storage.write(key: key, value: token);
  }

}


final loginProvider = StateNotifierProvider<AuthStateNotifier, Token>((ref) {

return AuthStateNotifier(ref);
}
);



 Future<String?> getToken(String key) async{
      final result =await storage.read(key:key);
      return result;
  }

 Future<void> deleteToken() async{
      await storage.deleteAll();
  }









// final loginProvider = FutureProvider.family <Token, Map> ((ref, body) async {
//   final dio=ref.watch(dioProvider);
//   final response = await dio.post(
//     'token/',
//     options: Options(
//       headers: {
//         Headers.contentTypeHeader: 'application/json',
//       }
//     ),
//     data: jsonEncode(body),
//     );
//     // return response.data;
//   if (response.statusCode==200) {
//     // return jsonDecode(response.data);
//     return response.data;
//   }
//   else{
//     throw Exception('Login Failed');
//   }

// }
// );