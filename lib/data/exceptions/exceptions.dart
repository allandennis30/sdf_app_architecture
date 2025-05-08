import 'package:sdf_app_architecture/utils/excepetions/exceptions.dart';

class LocalStoreException extends AppException {
  LocalStoreException(super.message, [super.stackTrace]);
}

class RemoteException extends AppException {
  RemoteException(super.message, [super.stackTrace]);
}
