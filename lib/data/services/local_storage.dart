import 'package:result_dart/result_dart.dart';
import 'package:sdf_app_architecture/data/exceptions/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  AsyncResult<String> saveData(String key, String value) async {
    try {
      final shared = await SharedPreferences.getInstance();
      shared.setString(key, value);
      return Success(value);
    } catch (e, s) {
      return Failure(LocalStoreException(e.toString(), s));
    }
  }

  AsyncResult<String> getData(String key) async {
    try {
      final shared = await SharedPreferences.getInstance();
      final value = shared.getString(key);
      return value != null
          ? Success(value)
          : Failure(LocalStoreException('No data found', null));
    } catch (e, s) {
      return Failure(LocalStoreException(e.toString(), s));
    }
  }

  AsyncResult<Unit> removeData(String key) async {
    try {
      final shared = await SharedPreferences.getInstance();
      shared.remove(key);
      return const Success(unit);
    } catch (e, s) {
      return Failure(LocalStoreException(e.toString(), s));
    }
  }
}
