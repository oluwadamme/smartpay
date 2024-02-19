import 'package:get_it/get_it.dart';
import 'package:smartpay/src/core/api_client.dart';
import 'package:smartpay/src/features/auth/data/repository/auth_repository.dart';

final locator = GetIt.instance;

void serviceLocator() {
  //API Service
  locator.registerFactory<ApiClient>(ApiClient.new);

  //Repository
  locator.registerLazySingleton<AuthRepository>(AuthRepository.new);
}

List repositories = [
  locator.get<AuthRepository>(),
];
