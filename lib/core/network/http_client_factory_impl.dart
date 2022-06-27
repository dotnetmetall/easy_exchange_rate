import 'package:dio/src/dio.dart';
import 'package:easy_exchange_rate/core/network/http_client_factory.dart';

class HttpClientFactoryImpl implements HttpClientFactory {
  final _baseUrlToClientMap = <String, Dio>{};

  @override
  Dio getHttpClient(String baseUrl) {
    if (_baseUrlToClientMap.containsKey(baseUrl)) {
      return _baseUrlToClientMap[baseUrl] as Dio;
    }

    var newClient = Dio();
    newClient.options.baseUrl = baseUrl;
    newClient.options.connectTimeout = 3000;
    newClient.options.receiveTimeout = 6000;

    _baseUrlToClientMap.addAll({baseUrl: newClient});

    return newClient;
  }
}
