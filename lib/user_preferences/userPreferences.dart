import 'package:shared_preferences/shared_preferences.dart';

class RememberUserPrefs{

  ///get-read user info
  ///remove user info
  static Future<void> removeUserInfo() async{
    SharedPreferences share01 = await SharedPreferences.getInstance();
    await share01.remove("currentUser");
  }
}