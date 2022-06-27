import 'package:easy_exchange_rate/domain/entities/currency.dart';
import 'package:easy_exchange_rate/presentation/rateslist/rates_list_cubit.dart';
import 'package:easy_exchange_rate/presentation/rateslist/rates_list_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:localization/localization.dart';

class RatesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CurrencySelector()),
      body: RatesListBody(),
    );
  }
}

class CurrencySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatesListCubit, RatesListState>(
        builder: (context, state) {
      if (state is InitializationState || state is FailedInitState) {
        return const SizedBox.shrink();
      }
      return Center(
          child: DropdownButton(
        alignment: AlignmentDirectional.centerStart,
        value: state.baseCurrency,
        items: state.availableCurrencies
            .map((e) => DropdownMenuItem<Currency>(value: e, child: Text(e.currencyCode)))
            .toList(),
        onChanged: (Currency? newValue) async => await context
            .read<RatesListCubit>()
            .changeBaseCurrencyAsync(newValue!),
      ));
    });
  }
}

class RatesListBody extends StatelessWidget {
  RatesListCubit? _ratesCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RatesListCubit, RatesListState>(
        builder: (context, state) {
      _ratesCubit ??= context.read<RatesListCubit>();

      if (state is RatesReceivedState) {
        return _BuildList(context, state);
      }

      if (state is LoadingRatesState || state is InitializationState) {
        return _BuildProgress();
      }

      return _BuildFailed();
    });
  }

  Widget _BuildList(
      BuildContext context, RatesReceivedState ratesReceivedState) {
    var formattedTimeStamp =
        DateFormat.yMMMMEEEEd().add_Hm().format(ratesReceivedState.lastUpdate);

    return Column(
      children: [
        Expanded(
            child: RefreshIndicator(
                onRefresh: () async => await _ratesCubit?.updateRatesAsync(),
                child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: ratesReceivedState.rates.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemBuilder: (_, index) {
                      var rate = ratesReceivedState.rates[index];
                      return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  Text("SSS"),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 16),
                                      child: Text(rate.currencyCode)),
                                ]),
                                Text(rate.rate.toStringAsFixed(2))
                              ]));
                    }))),
        Container(
          color: Theme.of(context).primaryColor,
          height: 50,
          child: Center(child: Text(formattedTimeStamp)),
        )
      ],
    );
  }

  Widget _BuildProgress() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _BuildFailed() {
    return Center(child: Text('SomethingWentWrong'.i18n()));
  }
}
