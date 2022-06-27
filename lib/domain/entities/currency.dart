import 'package:flutter/widgets.dart';

class Currency {
  late String currencyCode;
  late Icon? icon;

  Currency(this.currencyCode, [this.icon]);
  Currency.empty(){
      currencyCode = "";
  }

}