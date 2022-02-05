part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class AddUserInfo extends UserEvent{

  const AddUserInfo({this.user});

  final User? user;


  @override
  List<Object?> get props => [user];
}

class AuthUser extends UserEvent{

  const AuthUser({this.user, this.isAuth});

  final User? user;
  final bool? isAuth;


  @override
  List<Object?> get props => [user, isAuth];
}

class DeleteUserInfo extends UserEvent{

  const DeleteUserInfo();

  @override
  List<Object?> get props => [];
}

class ChangeUserInfo extends UserEvent{

  const ChangeUserInfo();

  @override
  List<Object?> get props => [];
}

class OverwritingUserInfo extends UserEvent{

  const OverwritingUserInfo();

  @override
  List<Object?> get props => [];
}
