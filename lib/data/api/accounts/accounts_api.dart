import 'package:http/http.dart' as http;
import 'dart:convert';

const baseUrl='http://10.28.164.119:8000/api/';



Future login(data) async{
  final response = await http.post(
    Uri.parse('${baseUrl}token/'),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(data),

    );
  if (response.statusCode==200) {
    return json.decode(response.body);
  }
  else{
    throw Exception('Login Failed');
  }
}