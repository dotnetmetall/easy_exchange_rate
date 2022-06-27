import 'package:easy_exchange_rate/core/error_data_pair.dart';
import 'package:easy_exchange_rate/domain/entities/currency.dart';
import '../entities/exchange_rates_collection.dart';

abstract class RatesProvider {
  Future<ErrorDataPair<Error, ExchangeRatesCollection>> getRatesAsync(
      String baseCurrencyCode);

  Future<ErrorDataPair<Error, List<Currency>>> getAvailableCurrenciesAsync();
}