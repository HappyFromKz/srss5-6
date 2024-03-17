import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  late SharedPreferences _sharedPreference;
  static const String PHONE = "phone";
  static const String EMAIL = "email";


  init() async {
    _sharedPreference = await SharedPreferences.getInstance();
  }

  String get phone {
    return _sharedPreference.getString(PHONE) ?? '';
  }

  Future<bool> setPhone(String phone) async {
    return _sharedPreference.setString(PHONE, phone);
  }

  String get email {
    return _sharedPreference.getString(EMAIL) ?? '';
  }

  Future<bool> setEmail(String email) async {
    return _sharedPreference.setString(EMAIL, email);
  }
}

final SharedPreferenceHelper sharedPreference = SharedPreferenceHelper();