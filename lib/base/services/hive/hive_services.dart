import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class MyHive {
  static Future<void> initializeHive() async {
    //! Ensure Hive is initialized before using it
    final appDocumentDirectory =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);

    //! Open the setting box
    MyHiveBoxes.settingBox = await Hive.openBox('setting');
  }
}

///!----------------    MyHive Boxes
class MyHiveBoxes {
  static late Box settingBox;
}

///!---------------      MyHive Keys
class MyHiveKeys {
  static const String userIsLoggedIn = "user_is_logged_in";
  static const String isAdminLoggedIn = "user_is_admin";
  static const String themeListIndex = "theme_index";
  
  static const String darkModeHiveKey = "hive_dark_mode";
  static const String showOnBoardingScreenHiveKey = "hive_show_on_boarding";
  static const String userNameHiveKey = "user_name";
  static const String userProfilePicHiveKey = "user_profile_pic";
  static const String userEmailHiveKey = "user_email";



}
