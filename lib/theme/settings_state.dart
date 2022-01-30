part of 'settings_bloc.dart';



class SettingsState extends Equatable {
  final ThemeData? currentTheme;
  final String? themeInfo;

  const SettingsState({this.currentTheme, this.themeInfo});

  SettingsState copyWith({
    ThemeData? currentTheme,
    String? themeInfo
  }) {
    return SettingsState(
      currentTheme: currentTheme ?? this.currentTheme,
      themeInfo: themeInfo ?? this.themeInfo
    );
  }

  @override
  List<Object?> get props => [currentTheme, themeInfo];
}

