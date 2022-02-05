part of 'singup_bloc.dart';

enum SingupStatus { initial, success, failure, loading, validFailure }

class SingupState extends Equatable {
  const SingupState({
    this.status = SingupStatus.initial,
    this.errorInfo,
    this.user,
    this.errorValid = "",
  });

  final SingupStatus? status;
  final FirebaseAuthException? errorInfo;
  final String? errorValid;
  final User? user;

  SingupState copyWith({
    SingupStatus? status,
    User? user,
    FirebaseAuthException? errorInfo,
    String? errorValid,
  }) {
    return SingupState(
      status: status ?? this.status,
      errorInfo: errorInfo ?? this.errorInfo,
      user: user ?? this.user,
      errorValid: errorValid ?? this.errorValid,
    );
  }

  @override
  List<Object?> get props => [status, errorValid, errorInfo, user];
}

