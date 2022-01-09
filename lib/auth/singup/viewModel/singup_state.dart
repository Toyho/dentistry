part of 'singup_bloc.dart';

enum SingupStatus { initial, success, failure, loading, validFailure }

class SingupState extends Equatable {
  const SingupState({
    this.status = SingupStatus.initial,
    this.errorInfo,
    this.errorValid = "",
  });

  final SingupStatus? status;
  final FirebaseAuthException? errorInfo;
  final String? errorValid;

  SingupState copyWith({
    SingupStatus? status,
    User? user,
    FirebaseAuthException? errorInfo,
    String? errorValid,
  }) {
    return SingupState(
      status: status ?? this.status,
      errorInfo: errorInfo ?? this.errorInfo,
      errorValid: errorValid ?? this.errorValid,
    );
  }

  @override
  List<Object?> get props => [status, errorValid, errorInfo];
}

