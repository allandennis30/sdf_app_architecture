import 'package:flutter/foundation.dart';
import 'package:result_command/result_command.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sdf_app_architecture/data/repositories/auth/auth_repository.dart';
import 'package:sdf_app_architecture/domain/entities/dtos/credentials.dart';
import 'package:sdf_app_architecture/domain/entities/user_entity.dart';

class LoginViewmodel extends ChangeNotifier {
  final AuthRepository _authRepository;
  LoginViewmodel(this._authRepository);

  late final loginCommand = Command1(_login);
  AsyncResult<LoggedUser> _login(Credentials credentials) {
    return _authRepository.login(credentials);
  }
}
