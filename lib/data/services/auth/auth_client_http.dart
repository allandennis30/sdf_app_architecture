import 'dart:isolate';

import 'package:result_dart/result_dart.dart';
import 'package:sdf_app_architecture/data/exceptions/exceptions.dart';
import 'package:sdf_app_architecture/data/services/auth/client_http.dart';
import 'package:sdf_app_architecture/domain/entities/dtos/credentials.dart';
import 'package:sdf_app_architecture/domain/entities/user_entity.dart';

class AuthClientHttp {
  final ClientHttp _clientHttp;

  AuthClientHttp(this._clientHttp);

  AsyncResult<LoggedUser> login(Credentials credentials) async {
/*     final response = await _clientHttp.post('/login', {
      'email': credentials.email,
      'password': credentials.password,
    });

    return response.map((response) {
      return LoggedUser.fromJson(response.data);
    }); */

    await Future.delayed(const Duration(seconds: 2));
    return const Success(
      LoggedUser(
        id: 1,
        name: 'Usuário Mock',
        email: 'mock@email.com',
        token: 'mock_token_123',
        refreshToken: 'mock_refresh_token_456',
      ),
    );
    //  return Failure(RemoteException('Erro ao fazer login'));
  }
}
