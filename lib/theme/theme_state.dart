part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {

  final ThemeData currentTheme;

  const ThemeState(this.currentTheme);

  @override
  List<Object?> get props => [currentTheme];
}

class ThemeInitial extends ThemeState {
  const ThemeInitial(ThemeData currentTheme) : super(currentTheme);

  @override
  List<Object> get props => [currentTheme];
}

class LightTheme extends ThemeState {
  const LightTheme(ThemeData currentTheme) : super(currentTheme);

  @override
  List<Object> get props => [currentTheme];
}

class DarkTheme extends ThemeState {
  const DarkTheme(ThemeData currentTheme) : super(currentTheme);

  @override
  List<Object> get props => [currentTheme];
}
