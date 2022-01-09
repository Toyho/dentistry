import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginBloc() : super(const LoginState()) {
    on<SignInWithEmailAndPassword>(_onSignInWithEmailAndPassword);
  }

  Future<void> _onSignInWithEmailAndPassword(
      SignInWithEmailAndPassword event, Emitter<LoginState> emit) async {
    final SharedPreferences prefs = await _prefs;
    emit(state.copyWith(status: LoginStatus.loading));
    validationAuth(event, emit);

    if (state.status == LoginStatus.validFailure) {
      return;
    }

    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      ))
          .user;

      if (user != null) {
        prefs.setString("uid_account", user.uid);
        emit(state.copyWith(status: LoginStatus.success, user: user));
      }
    } on FirebaseAuthException catch (error) {
      emit(state.copyWith(
          status: LoginStatus.failure, errorInfo: error));
    }
  }

  void validationAuth(SignInWithEmailAndPassword event, Emitter<LoginState> emit) {
    if (event.password.length < 6) {
      emit(state.copyWith(
        status: LoginStatus.validFailure,
        errorValid: "Пароль должен быть больше 6 знаков"
      ));
    }
    if (event.email.isEmpty) {
      emit(state.copyWith(
          status: LoginStatus.validFailure,
          errorValid: "Введите Вашу электронную почту"
      ));
    }
  }
}
