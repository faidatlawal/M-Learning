import 'package:shared_preferences/shared_preferences.dart';

class UserPreference{

  static String userLoggedInPreference = "isLoggedIn";
  static String userLoggedInLevel = "loggedUserLevel";
  static String userLoggedInEmail = "loggedUserEmail";
  static String userLoggedInName = "loggedUserName";
  static String userLoggedInMatricNo = "loggedUserMatricNo";
  static String userLoggedInGender = "loggedUserGender";
  static String userLoggedInRegDate = "loggedUserRegDate";
  static String userLoggedInRegTime = "loggedUserRegTime";

  // ========================= SETTING PREFERENCES ========================

  static Future <bool> setUserLoggedPreference({bool logPrefs})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setBool(userLoggedInPreference, logPrefs);
  }

  static Future setUserLoggedLevel({String userLoggedLevel})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setString(userLoggedInLevel, userLoggedLevel);
  }

  static Future setUserLoggedEmail({String userLoggedEmail})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setString(userLoggedInEmail, userLoggedEmail);
  }

  static Future setUserLoggedName({String userLoggedName})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setString(userLoggedInName, userLoggedName);
  }

  static Future setUserLoggedMatricNo({String userLoggedMatricNo})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setString(userLoggedInMatricNo, userLoggedMatricNo);
  }

  static Future setUserLoggedGender({String userLoggedGender})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setString(userLoggedInGender, userLoggedGender);
  }

  static Future setUserLoggedRegDate({String userLoggedRegDate})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setString(userLoggedInRegDate, userLoggedRegDate);
  }

  static Future setUserLoggedRegTime({String userLoggedRegTime})async{
    SharedPreferences preferences  = await SharedPreferences.getInstance();
    return await preferences.setString(userLoggedInRegTime, userLoggedRegTime);
  }

// ========================= GETTING PREFERENCES ========================

static Future <bool> getUserLoggedPreference()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(userLoggedInPreference);
}
  static Future getUserLoggedLevel()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return  preferences.getString(userLoggedInLevel);
  }

  static Future getUserLoggedEmail()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userLoggedInEmail);
  }

  static Future getUserLoggedName()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userLoggedInName);
  }

  static Future getUserLoggedMatricNo()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userLoggedInMatricNo);
  }

  static Future getUserLoggedGender()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userLoggedInGender);
  }

  static Future getUserLoggedRegDate()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userLoggedInRegDate);
  }

  static Future getUserLoggedRegTime()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userLoggedInRegTime);
  }

}