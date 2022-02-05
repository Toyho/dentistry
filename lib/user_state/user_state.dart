part of 'user_bloc.dart';

class UserState extends Equatable {
  const UserState({
    this.userUID = "",
    this.name = "",
    this.lastName = "",
    this.userAvatar = "",
    this.patronymic = "",
    this.passport = "",
    this.isAdmin = false,
    this.isAuth = false
  });

  final String? userUID;
  final String? name;
  final String? lastName;
  final String? userAvatar;
  final String? patronymic;
  final String? passport;
  final bool? isAdmin;
  final bool? isAuth;


  UserState copyWith({
    String? userUID,
    String? name,
    String? lastName,
    String? userAvatar,
    String? patronymic,
    String? passport,
    bool? isAuth,
    bool? isAdmin,
  }) {
    return UserState(
      userUID: userUID ?? this.userUID,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      userAvatar: userAvatar ?? this.userAvatar,
      patronymic: patronymic ?? this.patronymic,
      passport: passport ?? this.passport,
      isAuth: isAuth ?? this.isAuth,
      isAdmin: isAdmin ?? this.isAdmin,
    );
  }

  @override
  List<Object?> get props => [userUID, name, lastName, userAvatar, isAuth, isAdmin];
}

