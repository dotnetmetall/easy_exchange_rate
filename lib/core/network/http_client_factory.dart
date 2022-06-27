import 'package:dio/dio.dart';

abstract class HttpClientFactory {
  Dio getHttpClient(String baseUrl);
}