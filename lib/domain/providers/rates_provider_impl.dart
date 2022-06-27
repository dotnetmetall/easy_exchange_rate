import 'package:dio/dio.dart';
import 'package:easy_exchange_rate/core/app_configuration.dart';
import 'package:easy_exchange_rate/core/errors/api_error.dart';
import 'package:easy_exchange_rate/core/network/http_client_factory.dart';
import 'package:easy_exchange_rate/domain/entities/currency.dart';
import 'package:easy_exchange_rate/domain/entities/exchange_rates_collection.dart';
import 'package:easy_exchange_rate/domain/providers/rates_provider.dart';

import '../../core/error_data_pair.dart';

class RatesProviderImpl implements RatesProvider {
  late final Dio _httpClient;

  RatesProviderImpl(
      {required HttpClientFactory httpClientFactory,
      required AppConfiguration appConfiguration}) {
    _httpClient = httpClientFactory.getHttpClient(appConfiguration.apiDomain);
    _httpClient.options.queryParameters
        .addAll({"api_key": appConfiguration.apiKey});
  }

  @override
  Future<ErrorDataPair<Error, ExchangeRatesCollection>> getRatesAsync(
      String baseCurrency) async {
    try {
      //Free plan allows to execute one request per second
      await Future.delayed(const Duration(seconds: 2));

      var response = await _httpClient.get<Map<String, dynamic>>("/v1/live",
          queryParameters: {"base": baseCurrency});

      if (response.statusCode != 200) {
        return ErrorDataPair.fromError(error: ApiError());
      }

      var exchangeRatesCollection = ExchangeRatesCollection.fromJson(
          response.data as Map<String, dynamic>);

      return ErrorDataPair.fromData(data: exchangeRatesCollection);
    } catch (e) {
      return ErrorDataPair.fromError(error: ApiError());
    }
  }

  @override
  Future<ErrorDataPair<Error, List<Currency>>>
      getAvailableCurrenciesAsync() async {
    //available currencies from https://app.abstractapi.com/api/exchange-rates/documentation

    return ErrorDataPair.fromData(data: [
      Currency("USD"),
      Currency("EUR"),
      Currency("GBP"),
      Currency("ARS"),
      Currency("AUD"),
      Currency("BCH"),
      Currency("BGN"),
      Currency("BNB"),
      Currency("BRL"),
      Currency("BTC"),
      Currency("CAD"),
      Currency("CHF"),
      Currency("CNY"),
      Currency("CZK"),
      Currency("DKK"),
      Currency("DOGE"),
      Currency("DZD"),
      Currency("ETH"),
      Currency("HKD"),
      Currency("HRK"),
      Currency("HUF"),
      Currency("IDR"),
      Currency("ILS"),
      Currency("INR"),
      Currency("ISK"),
      Currency("JPY"),
      Currency("KRW"),
      Currency("LTC"),
      Currency("MAD"),
      Currency("MXN"),
      Currency("MYR"),
      Currency("NOK"),
      Currency("NZD"),
      Currency("PHP"),
      Currency("PLN")
    ]);
  }
}
