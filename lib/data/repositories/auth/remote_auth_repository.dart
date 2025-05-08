import 'dart:async';
import 'package:result_dart/result_dart.dart';
import 'package:sdf_app_architecture/data/repositories/auth/auth_repository.dart';
import 'package:sdf_app_architecture/data/services/auth/auth_client_http.dart';
import 'package:sdf_app_architecture/data/services/auth/auth_local_storage.dart';
import 'package:sdf_app_architecture/domain/entities/dtos/credentials.dart';
import 'package:sdf_app_architecture/domain/entities/user_entity.dart';
import 'package:sdf_app_architecture/domain/validators/credentials_validator.dart';
import 'package:sdf_app_architecture/utils/validation/lucid_validator_extension.dart';

class RemoteAuthRepository implements AuthRepository {
  RemoteAuthRepository(this._authLocalStorage, this._authClientHttp);
  final AuthLocalStorage _authLocalStorage;
  final AuthClientHttp _authClientHttp;

  final _streamController = StreamController<User>.broadcast();

  @override
  AsyncResult<LoggedUser> getUser() {
    return _authLocalStorage.getUser();
  }

  @override
  AsyncResult<LoggedUser> login(Credentials credentials) async {
    final validator = CredentialsValidator();

    return validator
        .validateResult(credentials)
        .flatMap(_authClientHttp.login)
        .flatMap(_authLocalStorage.saveUser)
        .onSuccess(_streamController.add);
  }

  @override
  AsyncResult<Unit> logout() {
    return _authLocalStorage.removeUser().onSuccess(
          (_) => _streamController.add(const NotLoggedUser()),
        );
  }

  @override
  Stream<User> userObserver() {
    return _streamController.stream;
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
