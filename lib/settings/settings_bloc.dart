import 'package:bloc/bloc.dart';
import 'package:dentistry/l10n/all_locales.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'theme/app_themes.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends HydratedBloc<SettingsEvent, SettingsState> {
  SettingsBloc()
      : super(SettingsState(
            currentTheme: lightTheme,
            themeInfo: "light",
            textInfo: "en")) {
    on<CurrentAppTheme>(_currentAppTheme);
    on<ChangeLocalization>(_changeLocalization);
  }

  void _currentAppTheme(CurrentAppTheme event, Emitter<SettingsState> emit) {
    if (state.currentTheme == lightTheme) {
      emit(state.copyWith(currentTheme: darkTheme, themeInfo: "dark"));
    } else {
      emit(state.copyWith(currentTheme: lightTheme, themeInfo: "light"));
    }
  }

  void _changeLocalization(
      ChangeLocalization event, Emitter<SettingsState> emit) {
    if (state.textInfo == "ru") {
      emit(state.copyWith(textInfo: "en", locale: AllLocale.all[1]));
    } else {
      emit(state.copyWith(textInfo: "ru", locale: AllLocale.all[0]));
    }
  }

  @override
  SettingsState fromJson(Map<String, dynamic> json) {
    return SettingsState().copyWith(
        currentTheme: json['theme'] == "dark" ? darkTheme : lightTheme,
        themeInfo: json['theme'],
        locale: json['text'] == "ru" ? AllLocale.all[0] : AllLocale.all[1],
        textInfo: json['text']);
  }

  @override
  Map<String, dynamic> toJson(SettingsState state) {
    return {
      'theme': state.themeInfo!,
      'text': state.textInfo!,
    };
  }
}
