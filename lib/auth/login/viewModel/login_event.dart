part of 'login_bloc.dart';

@immutable
abstract class LoginEvent{}

class SignInWithEmailAndPassword extends LoginEvent {
  final String email;
  final String password;

  SignInWithEmailAndPassword({required this.email, required this.password});

}
