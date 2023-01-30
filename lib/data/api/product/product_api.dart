import 'package:http/http.dart' as http;
import 'dart:convert';

const baseUrl='http://10.28.164.119:8000/api/';

Future<List> fetchProducts() async{
  final response = await http.get(Uri.parse('${baseUrl}products/'));
  if (response.statusCode==200) {
    return json.decode(response.body);
  }
  else{
    throw Exception('Failed to load product');
  }
}