import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dentistry/models/user/users.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {

  Users? user;

  UserBloc() : super(const UserState()) {
    on<AddUserInfo>(_addUserInfo);
    on<DeleteUserInfo>(_deleteUserInfo);
    on<OverwritingUserInfo>(_overwritingUserInfo);
    on<AuthUser>(_authUser);
  }

  Future<void> _authUser(AuthUser event, Emitter<UserState> emit) async {
    await FirebaseDatabase.instance
        .ref()
        .child("users").child(event.user!.uid)
        .once().then((_){
      DatabaseEvent snapshot = _;
      user = Users.fromJson(snapshot.snapshot.value);
    }).whenComplete(() => emit(state.copyWith(userUID: user!.uid, userAvatar: user!.avatar, name: user!.name, lastName: user!.lastName, patronymic: user!.patronymic, passport: user!.passport, isAuth: event.isAuth, isAdmin: user!.admin)));

  }

  Future<void> _addUserInfo(AddUserInfo event, Emitter<UserState> emit) async {

    await FirebaseDatabase.instance
        .ref()
        .child("users").child(event.user!.uid)
        .once().then((_){
      DatabaseEvent snapshot = _;
      user = Users.fromJson(snapshot.snapshot.value);
    }).whenComplete(() => emit(state.copyWith(userUID: user!.uid, userAvatar: user!.avatar, name: user!.name, lastName: user!.lastName, patronymic: user!.patronymic, passport: user!.passport, isAdmin: user!.admin)));
  }

  Future<void> _overwritingUserInfo(OverwritingUserInfo event, Emitter<UserState> emit) async {

    await FirebaseDatabase.instance
        .ref()
        .child("users").child(state.userUID!)
        .once().then((_){
      DatabaseEvent snapshot = _;
      user = Users.fromJson(snapshot.snapshot.value);
    }).whenComplete(() => emit(state.copyWith(userUID: user!.uid, userAvatar:  user!.avatar , name: user!.name, patronymic: user!.patronymic, passport: user!.passport, lastName: user!.lastName, isAdmin: user!.admin)));
  }

  Future<void> _deleteUserInfo(DeleteUserInfo event, Emitter<UserState> emit) async {
    await FirebaseAuth.instance.signOut();
    emit(state.copyWith(name: "", lastName: "", userUID: "", userAvatar: "", patronymic: "", passport: "", isAuth: false, isAdmin: false));
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    return UserState().copyWith(
        userUID: json['userUID'],
        name: json['name'],
        lastName: json['lastName'],
        userAvatar: json['userAvatar'],
        patronymic: json['patronymic'],
        passport: json['passport'],
        isAuth: json['isAuth'],
        isAdmin: json['isAdmin']);
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return {
      'userUID': state.userUID!,
      'name': state.name!,
      'lastName': state.lastName!,
      'userAvatar': state.userAvatar!,
      'patronymic': state.patronymic!,
      'passport': state.passport!,
      'isAuth': state.isAuth!,
      'isAdmin': state.isAdmin!,
    };
  }
}
