import 'package:easy_exchange_rate/core/app_configuration.dart';
import 'package:easy_exchange_rate/presentation/rateslist/rates_list_cubit.dart';
import 'package:easy_exchange_rate/presentation/rateslist/rates_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization/localization.dart';

import 'domain/providers/rates_provider.dart';

void main() {
  configureApp();
  LocalJsonLocalization.delegate.directories = ['lib/i18n'];

  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => RatesListCubit(locator.get<RatesProvider>())),
        ],
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            LocalJsonLocalization.delegate,
          ],
          debugShowCheckedModeBanner: true,
          supportedLocales: const [
            Locale('en', 'US'),
          ],
          home: RatesPage(),
          theme: ThemeData(
            colorScheme: const ColorScheme.dark()
          ),
        ));
  }
}
