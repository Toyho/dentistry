part of 'singup_bloc.dart';

@immutable
abstract class SingupEvent{}

class SignUpWithEmailAndPassword extends SingupEvent {
  final String email;
  final String password;
  final String confirmPassword;

  SignUpWithEmailAndPassword({required this.email, required this.password, required this.confirmPassword});

}