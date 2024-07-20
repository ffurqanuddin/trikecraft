import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trikecraft/base/services/hive/hive_services.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(
            isDarkMode: MyHiveBoxes.settingBox.get(
              MyHiveKeys.darkModeHiveKey,
              defaultValue: false,
            ),
            themeIndex: MyHiveBoxes.settingBox.get(
              MyHiveKeys.themeListIndex,
              defaultValue: 0,
            )));

  void toggleTheme() async {
    try {
      final currentMode = state.isDarkMode;
      final newMode = !currentMode;

      // Update the state immediately for a responsive UI
      emit(state.copyWith(isDarkMode: newMode));

      // Persist the new mode in Hive
      await MyHiveBoxes.settingBox.put(MyHiveKeys.darkModeHiveKey, newMode);
    } catch (e) {
      // Handle any errors (e.g., logging)
      print('Error changing theme: $e');
      // Revert state in case of an error
      emit(state.copyWith(isDarkMode: !state.isDarkMode));
    }
  }

  void changeTheme({required String name}) async {
    switch (name) {
      case "amber":
        // Update the theme Index
        emit(state.copyWith(themeIndex: 0));
        // Persist the new mode in Hive
        await MyHiveBoxes.settingBox.put(MyHiveKeys.themeListIndex, 0);

      case "pinkm3":
        // Update the theme Index
        emit(state.copyWith(themeIndex: 1));
        // Persist the new mode in Hive
        await MyHiveBoxes.settingBox.put(MyHiveKeys.themeListIndex, 1);

      case "indigom3":
        // Update the theme Index
        emit(state.copyWith(themeIndex: 2));
        // Persist the new mode in Hive
        await MyHiveBoxes.settingBox.put(MyHiveKeys.themeListIndex, 2);

          case "redm3":
        // Update the theme Index
        emit(state.copyWith(themeIndex: 3));
        // Persist the new mode in Hive
        await MyHiveBoxes.settingBox.put(MyHiveKeys.themeListIndex, 3);

          case "redwine":
        // Update the theme Index
        emit(state.copyWith(themeIndex: 4));
        // Persist the new mode in Hive
        await MyHiveBoxes.settingBox.put(MyHiveKeys.themeListIndex, 4);

                  case "bluem3":
        // Update the theme Index
        emit(state.copyWith(themeIndex: 5));
        // Persist the new mode in Hive
        await MyHiveBoxes.settingBox.put(MyHiveKeys.themeListIndex, 5);

                  case "cyanm3":
        // Update the theme Index
        emit(state.copyWith(themeIndex: 6));
        // Persist the new mode in Hive
        await MyHiveBoxes.settingBox.put(MyHiveKeys.themeListIndex, 6);
                  case "deeppurple":
        // Update the theme Index
        emit(state.copyWith(themeIndex: 7));
        // Persist the new mode in Hive
        await MyHiveBoxes.settingBox.put(MyHiveKeys.themeListIndex, 7);

      default:
        // Update the theme Index
        emit(state.copyWith(themeIndex: 0));
        // Persist the new mode in Hive
        await MyHiveBoxes.settingBox.put(MyHiveKeys.themeListIndex, 0);
    }
  }
}
