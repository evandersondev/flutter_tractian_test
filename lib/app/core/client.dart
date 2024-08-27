import 'package:dio/dio.dart';

final client = Dio(
  BaseOptions(
    baseUrl: 'https://fake-api.tractian.com/',
    connectTimeout: const Duration(seconds: 5),
  ),
);
