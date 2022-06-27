import 'package:easy_exchange_rate/core/network/http_client_factory.dart';
import 'package:easy_exchange_rate/core/network/http_client_factory_impl.dart';
import 'package:easy_exchange_rate/domain/providers/rates_provider_impl.dart';
import 'package:get_it/get_it.dart';

import '../domain/providers/rates_provider.dart';

GetIt get locator  => GetIt.instance;

void configureApp() {
  _configureDependencies();
}

void _configureDependencies() {

  locator.registerSingleton<AppConfiguration>(AppConfigurationIml());
  locator.registerLazySingleton<HttpClientFactory>(() => HttpClientFactoryImpl());
  locator.registerLazySingleton<RatesProvider>(() =>
      RatesProviderImpl(httpClientFactory: locator.get<HttpClientFactory>(), appConfiguration: locator.get<AppConfiguration>()));
}

abstract class AppConfiguration {
  String get apiDomain;
  String get apiKey;
}

class AppConfigurationIml implements AppConfiguration{
  @override
  String get apiDomain => "https://exchange-rates.abstractapi.com";

  @override
  String get apiKey => "3f7a625ac475430ebb8204b30096d954";

}