import 'package:auto_injector/auto_injector.dart';
import 'package:dio/dio.dart';
import 'package:sdf_app_architecture/data/repositories/auth/auth_repository.dart';
import 'package:sdf_app_architecture/data/repositories/auth/remote_auth_repository.dart';
import 'package:sdf_app_architecture/data/services/auth/auth_client_http.dart';
import 'package:sdf_app_architecture/data/services/auth/auth_local_storage.dart';
import 'package:sdf_app_architecture/data/services/auth/client_http.dart';
import 'package:sdf_app_architecture/data/services/local_storage.dart';
import 'package:sdf_app_architecture/ui/auth/login/viewModels/login_viewmodel.dart';
import 'package:sdf_app_architecture/ui/auth/logout/viewmodels/logout_viewmodel.dart';

final injector = AutoInjector();

void setupDependencies() {
  injector.addSingleton<AuthRepository>(RemoteAuthRepository.new);
  injector.addInstance(Dio());
  injector.addSingleton(ClientHttp.new);
  injector.addSingleton(LocalStorage.new);
  injector.addSingleton(AuthClientHttp.new);
  injector.addSingleton(AuthLocalStorage.new);
  injector.addSingleton(LoginViewmodel.new);
  injector.addSingleton(LogoutViewmodel.new);
}
