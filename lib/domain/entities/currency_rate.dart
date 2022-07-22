class CurrencyRate {
  late String currencyCode;
  late double rate;

  CurrencyRate(this.currencyCode, double rate) {
    this.rate = 1.0 / rate;
  }
}
