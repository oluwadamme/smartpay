import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartpay/src/features/auth/data/controller/auth_state.dart';
import 'package:smartpay/src/features/auth/data/repository/auth_repository.dart';
import 'package:smartpay/src/utils/service_locator.dart';

class DashboardProvider extends Cubit<AuthState> {
  DashboardProvider() : super(AuthState());
  void dashboard(String token) async {
    emit(AuthState(data: null, loading: true));
    try {
      final resp = await locator.get<AuthRepository>().dashboard(token);
      if (resp.hasError()) {
        emit(AuthState(loading: false, error: resp.error!.message));
      } else {
        emit(AuthState(data: resp.response.toString(), loading: false));
      }
    } catch (e) {
      emit(AuthState(data: null, loading: false, error: e.toString()));
    }
  }
}
