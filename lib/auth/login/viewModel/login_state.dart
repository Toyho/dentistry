part of 'login_bloc.dart';

enum LoginStatus { initial, success, failure, loading, validFailure }

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.initial,
    this.user,
    this.errorInfo,
    this.errorValid = "",
  });

  final LoginStatus? status;
  final User? user;
  final FirebaseAuthException? errorInfo;
  final String? errorValid;

  LoginState copyWith({
    LoginStatus? status,
    User? user,
    FirebaseAuthException? errorInfo,
    String? errorValid,
  }) {
    return LoginState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorInfo: errorInfo ?? this.errorInfo,
      errorValid: errorValid ?? this.errorValid,
    );
  }

  @override
  List<Object?> get props => [status, user, errorInfo, errorValid];
}

