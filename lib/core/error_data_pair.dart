class ErrorDataPair<E, D> {
  final E? error;
  final D? data;

  ErrorDataPair({required E this.error, required D this.data});

  ErrorDataPair.fromError({required this.error}) : data = null;

  ErrorDataPair.fromData({required this.data}) : error = null;

  bool get hasError => error != null;
}
