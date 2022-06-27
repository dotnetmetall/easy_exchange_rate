import 'package:easy_exchange_rate/domain/entities/currency_rate.dart';

import '../../domain/entities/currency.dart';

abstract class RatesListState {
  late final Currency baseCurrency;
  late final List<Currency> availableCurrencies;

  RatesListState(this.baseCurrency, this.availableCurrencies);
}

class LoadingRatesState extends RatesListState {
  LoadingRatesState(super.baseCurrency, super.availableCurrencies);
}

class RatesReceivedState extends RatesListState {
  final List<CurrencyRate> rates;
  final DateTime lastUpdate;

  RatesReceivedState(this.lastUpdate, this.rates, super.baseCurrency, super.availableCurrencies);
}

class FailedReceivingState extends RatesListState {
  FailedReceivingState(super.baseCurrency, super.availableCurrencies);
}

class InitializationState extends RatesListState{
  InitializationState() : super(Currency.empty(), List<Currency>.empty());
}

class FailedInitState  extends RatesListState {
  FailedInitState() : super(Currency.empty(), List<Currency>.empty());
}