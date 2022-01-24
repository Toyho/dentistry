import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'app_themes.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial(lightTheme)) {
    on<CurrentAppTheme>(_currentAppTheme);
  }

  void _currentAppTheme( CurrentAppTheme event, Emitter<ThemeState> emit) {
    if (state.currentTheme == lightTheme) {
      emit(DarkTheme(darkTheme));
    } else {
      emit(LightTheme(lightTheme));
    }
  }
}
