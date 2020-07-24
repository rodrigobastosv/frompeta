import 'package:dio/dio.dart';

Dio getDefaultClient() {
  return Dio(
    BaseOptions(baseUrl: 'https://run.mocky.io/v3/'),
  );
}
