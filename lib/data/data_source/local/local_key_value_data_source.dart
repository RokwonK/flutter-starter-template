
import 'package:shared_preferences/shared_preferences.dart';

class LocalKeyValueDataSource {
  SharedPreferences? _db;

  Future<SharedPreferences> get database async {
    if (_db != null) return _db!;
    _db = await SharedPreferences.getInstance();
    return _db!;
  }
}

enum LocalKey {
  memberId
}