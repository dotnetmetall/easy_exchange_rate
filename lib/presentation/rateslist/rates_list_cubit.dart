import 'package:easy_exchange_rate/domain/providers/rates_provider.dart';
import 'package:easy_exchange_rate/presentation/rateslist/rates_list_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/currency.dart';

class RatesListCubit extends Cubit<RatesListState> {
  late final RatesProvider _ratesProvider;
  late List<Currency> _availableCurrencies;

  late Currency _baseCurrency;

  RatesListCubit(this._ratesProvider) : super(InitializationState()) {
    _InitCubitAsync();
  }

  Future updateRatesAsync() async {
    await _GetRatesInternalAsync();
  }

  Future changeBaseCurrencyAsync(Currency baseCurrency) async {
    if (_baseCurrency == baseCurrency) return;

    _baseCurrency = baseCurrency;

    emit(LoadingRatesState(_baseCurrency, _availableCurrencies));
    await _GetRatesInternalAsync();
  }

  Future _InitCubitAsync() async {
    var errorDataPair = await _ratesProvider.getAvailableCurrenciesAsync();
    if (errorDataPair.hasError) {
      emit(FailedInitState());
    } else {
      _availableCurrencies = errorDataPair.data!;
      _baseCurrency = _availableCurrencies.first;
      await _GetRatesInternalAsync();
    }
  }

  Future _GetRatesInternalAsync() async {
    var ratesWrapper = await _ratesProvider.getRatesAsync(_baseCurrency.currencyCode);
    if (!ratesWrapper.hasError) {
      emit(RatesReceivedState(ratesWrapper.data!.lastUpdate, ratesWrapper.data!.rates, _baseCurrency,
          _availableCurrencies));
    } else {
      emit(FailedReceivingState(_baseCurrency, _availableCurrencies));
    }
  }
}
