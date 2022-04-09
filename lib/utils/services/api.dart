import 'package:currency_app/constants/dio_options.dart';
import 'package:dio/dio.dart';

class Client {
  final Dio dio;
  Client():
    dio = Dio(dioOptions);
}
