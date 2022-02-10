part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.userUID = "",
    this.name = "",
    this.lastName = "",
    this.userAvatar = "",
    this.patronymic = "",
    this.passport = "",
    this.email = "",
    this.isAdmin = false,
    this.isAuth = false,
    this.dateOfBirth = ""
  });

  final String? userUID;
  final String? name;
  final String? lastName;
  final String? userAvatar;
  final String? patronymic;
  final String? passport;
  final String? email;
  final bool? isAdmin;
  final bool? isAuth;
  final String? dateOfBirth;


  UserState copyWith({
    String? userUID,
    String? name,
    String? lastName,
    String? userAvatar,
    String? patronymic,
    String? passport,
    String? email,
    bool? isAuth,
    bool? isAdmin,
    String? dateOfBirth,
  }) {
    return UserState(
      userUID: userUID ?? this.userUID,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      userAvatar: userAvatar ?? this.userAvatar,
      patronymic: patronymic ?? this.patronymic,
      passport: passport ?? this.passport,
      email: email ?? this.email,
      isAuth: isAuth ?? this.isAuth,
      isAdmin: isAdmin ?? this.isAdmin,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    );
  }

  @override
  List<Object?> get props => [userUID, name, lastName, userAvatar, patronymic, passport, email, isAuth, isAdmin, dateOfBirth];
}

