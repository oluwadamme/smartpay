class DashState<T> {
  final bool loading;
  final String? error;
  final T? data;

  DashState({this.loading = false, this.error, this.data});
}
