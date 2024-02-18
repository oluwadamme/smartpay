import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartpay/src/features/auth/data/controller/auth_state.dart';
import 'package:smartpay/src/features/auth/data/model/login_response.dart';
import 'package:smartpay/src/features/auth/data/model/register_request.dart';
import 'package:smartpay/src/features/auth/data/repository/auth_repository.dart';
import 'package:smartpay/src/utils/service_locator.dart';

class AuthProvider extends Cubit<AuthState> {
  AuthProvider() : super(AuthState(data: null));

  final regRequest = RegisterRequest();
  LoginResponse? loginResponse;
  Future<void> login(String email, String password) async {
    emit(AuthState(data: null, loading: true));
    try {
      final resp = await locator.get<AuthRepository>().login(email, password);
      if (resp.hasError()) {
        emit(AuthState(loading: false, error: resp.error!.message));
      } else {
        loginResponse = resp.response as LoginResponse;
        emit(AuthState(data: resp.response as LoginResponse, loading: false));
      }
    } catch (e) {
      emit(AuthState(data: null, loading: false, error: e.toString()));
    }
  }

  Future<void> register(RegisterRequest request) async {
    emit(AuthState(data: null, loading: true));
    try {
      final resp = await locator.get<AuthRepository>().registration(request);
      if (resp.hasError()) {
        emit(AuthState(loading: false, error: resp.error!.message));
      } else {
        emit(AuthState(data: resp.response as LoginResponse, loading: false));
      }
    } catch (e) {
      emit(AuthState(data: null, loading: false, error: e.toString()));
    }
  }

  Future<void> getToken(String email) async {
    emit(AuthState(data: null, loading: true));
    try {
      final resp = await locator.get<AuthRepository>().getEmailTokem(email);
      if (resp.hasError()) {
        emit(AuthState(loading: false, error: resp.error!.message));
      } else {
        emit(AuthState(data: resp.response.toString(), loading: false));
      }
    } catch (e) {
      emit(AuthState(data: null, loading: false, error: e.toString()));
    }
  }

  Future<void> validateToken(String email, String token) async {
    emit(AuthState(data: null, loading: true));
    try {
      final resp = await locator.get<AuthRepository>().verifyEmailTokem(email, token);
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
