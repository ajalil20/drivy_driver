import 'package:drivy_user/Utils/local_db_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static SharedPreference? _sharedPreferenceHelper;
  static SharedPreferences? _sharedPreferences;

  SharedPreference._createInstance();

  factory SharedPreference() {
    _sharedPreferenceHelper ??= SharedPreference._createInstance();
    return _sharedPreferenceHelper!;
  }

  Future<SharedPreferences> get sharedPreference async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  ////////////////////// Clear Preference ///////////////////////////
  void clear() {_sharedPreferences!.clear();}

  ////////////////////// Bearer Token ///////////////////////////

  void setBearerToken({String? token}) {
    _sharedPreferences?.setString(LocalDBKeys.TOKEN, token ?? "");
  }

  String? getBearerToken() {
    return _sharedPreferences?.getString(LocalDBKeys.TOKEN);
  }

  void setFcmToken({String? token}) {
    _sharedPreferences!.setString(LocalDBKeys.FCM, token ?? "");
  }

  String? getFcmToken() {
    return _sharedPreferences?.getString(LocalDBKeys.FCM);
  }

  void setCart({String? cart}) {
    _sharedPreferences!.setString(LocalDBKeys.CART, cart ?? "");
  }

  String? getCart() {
    return _sharedPreferences!.getString(LocalDBKeys.CART);
  }

  ////////////////////// User ///////////////////////////
  void setUser({String? user}) {
    _sharedPreferences?.setString(LocalDBKeys.USER, user ?? "");
  }

  String? getUser() {
    return _sharedPreferences!.getString(LocalDBKeys.USER);
  }


  ////////////////////// Notification Message Id ///////////////////////////
  // void setNotificationMessageId({String? messageId}) {
  //   _sharedPreferences!.setString(LocalDBKeys.NOTIFICATION_MESSAGE_ID_KEY, messageId ?? "");
  // }
  //
  // String? getNotificationMessageId() {
  //   return _sharedPreferences!.getString(LocalDBKeys.NOTIFICATION_MESSAGE_ID_KEY);
  // }





}
