import 'package:easy_exchange_rate/domain/entities/currency_rate.dart';

class ExchangeRatesCollection {
  final List<CurrencyRate> rates;
  late DateTime lastUpdate;

  ExchangeRatesCollection.fromJson(Map<String, dynamic> json)
      : rates = <CurrencyRate>[] {
    final int lastUpdateUnixEpoch = json["last_updated"];

    lastUpdate = DateTime.fromMillisecondsSinceEpoch(lastUpdateUnixEpoch * 1000);

    final Map<String, dynamic> ratesJson = json["exchange_rates"];

    for (var currencyRateKeyValue in ratesJson.entries) {
      var currencyCode = currencyRateKeyValue.key;
      double rate = currencyRateKeyValue.value;

      rates.add(CurrencyRate(currencyCode, rate));
    }
  }
}
