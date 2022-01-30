import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'app_themes.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsState(currentTheme: lightTheme, themeInfo: "light")) {
    on<CurrentAppTheme>(_currentAppTheme);
  }

  void _currentAppTheme(CurrentAppTheme event, Emitter<SettingsState> emit) {
    if (state.currentTheme == lightTheme) {
      emit(
          SettingsState().copyWith(currentTheme: darkTheme, themeInfo: "dark"));
    } else {
      emit(SettingsState()
          .copyWith(currentTheme: lightTheme, themeInfo: "light"));
    }
  }

  @override
  SettingsState fromJson(Map<String, dynamic> json) {
    return SettingsState().copyWith(
        currentTheme: json['theme'] == "dark" ? darkTheme : lightTheme,
        themeInfo: json['theme']);
  }

  @override
  Map<String, dynamic> toJson(SettingsState state) {
    return {
      'theme': state.themeInfo!,
    };
  }
}
