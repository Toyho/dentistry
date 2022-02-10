part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final ThemeData? currentTheme;
  final String? themeInfo;
  final String? textInfo;
  final Locale? locale;

  const SettingsState({this.currentTheme, this.themeInfo, this.textInfo, this.locale});

  SettingsState copyWith(
      {ThemeData? currentTheme, String? themeInfo, String? textInfo, Locale? locale}) {
    return SettingsState(
        currentTheme: currentTheme ?? this.currentTheme,
        themeInfo: themeInfo ?? this.themeInfo,
        textInfo: textInfo ?? this.textInfo,
        locale: locale ?? this.locale);
  }

  @override
  List<Object?> get props => [currentTheme, themeInfo, textInfo, locale];
}
