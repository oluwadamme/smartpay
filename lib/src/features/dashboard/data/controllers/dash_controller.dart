import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartpay/src/features/dashboard/data/controllers/dash_state.dart';
import 'package:smartpay/src/features/dashboard/data/repository/dash_repository.dart';

class DashboardProvider extends Cubit<DashState> {
  DashboardProvider(this._repository) : super(DashState());
  final DashboardRepository _repository;
  void dashboard() async {
    emit(DashState(loading: true));
    try {
      final resp = await _repository.dashboard();
      if (resp.hasError()) {
        emit(DashState(error: resp.error!.message));
      } else {
        emit(DashState(data: resp.response.toString()));
      }
    } catch (e) {
      emit(DashState(error: e.toString()));
    }
  }

  void logout() async {
    emit(DashState(loading: true));
    try {
      final resp = await _repository.logout();
      if (resp.hasError()) {
        emit(DashState(loading: false, error: resp.error!.message));
      } else {
        emit(DashState(data: resp.response.toString()));
      }
    } catch (e) {
      emit(DashState(error: e.toString()));
    }
  }
}
