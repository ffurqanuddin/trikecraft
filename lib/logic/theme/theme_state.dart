part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  ThemeState({required this.isDarkMode, required this.themeIndex});

  bool isDarkMode;
  int themeIndex;

  ThemeState copyWith({isDarkMode, themeIndex}) {
    return ThemeState(isDarkMode: isDarkMode ?? this.isDarkMode, themeIndex: themeIndex?? this.themeIndex);
  }

  @override
  List<Object> get props => [isDarkMode, themeIndex];
}
