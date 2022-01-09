import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'singup_event.dart';

part 'singup_state.dart';

class SingupBloc extends Bloc<SingupEvent, SingupState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _fb = FirebaseDatabase.instance;
  late User? _user;

  SingupBloc() : super(const SingupState()) {
    on<SignUpWithEmailAndPassword>(_onSignUpWithEmailAndPassword);
  }

  Future<void> _onSignUpWithEmailAndPassword(
      SignUpWithEmailAndPassword event, Emitter<SingupState> emit) async {
    emit(state.copyWith(status: SingupStatus.loading));

    validationSingup(event, emit);

    if (state.status == SingupStatus.validFailure) return;

    try {
      _user = (await _auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      ))
          .user;
      if (_user != null) {
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
        _fb.reference().child("users").child(_user!.uid).set({
          'email': _user!.email!,
          'password': event.password,
          "registration_date": formattedDate
        });
        emit(state.copyWith(
          status: SingupStatus.success,
        ));
      }
    } on FirebaseAuthException catch (error) {
      emit(state.copyWith(status: SingupStatus.failure, errorInfo: error));
    }
  }

  void validationSingup(
      SignUpWithEmailAndPassword event, Emitter<SingupState> emit) {
    if (event.password != event.confirmPassword) {
      emit(state.copyWith(
          status: SingupStatus.validFailure,
          errorValid: "Пароли не совпадают"));
    }
    if (event.password.length < 6) {
      emit(state.copyWith(
          status: SingupStatus.validFailure,
          errorValid: "Пароль должен быть больше 6 знаков"));
    }
    if (event.email.isEmpty) {
      emit(state.copyWith(
          status: SingupStatus.validFailure,
          errorValid: "Введите Вашу электронную почту"));
    }
  }
}
