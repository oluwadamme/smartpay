class AuthState<T> {
  final bool loading;
  final String? error;
  final T? data;

  AuthState({this.loading = false, this.error, this.data});
}
