import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../keys/keys.dart';


final dioProvider = Provider <Dio> ((ref){
  return Dio(BaseOptions(
    baseUrl:KeyConfig.BASE_URL,
  )
  );
}
);