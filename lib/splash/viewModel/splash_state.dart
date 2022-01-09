part of 'splash_cubit.dart';

enum AuthCheckStatus { checking, isAuth, isNotAuth }

class SplashState extends Equatable {
  const SplashState({
    this.status = AuthCheckStatus.checking,
    this.uid,
  });

  final AuthCheckStatus? status;
  final String? uid;

  SplashState copyWith({
    AuthCheckStatus? status,
    String? uid,
  }) {
    return SplashState(
      status: status ?? this.status,
      uid: uid ?? this.uid,
    );
  }

  @override
  List<Object?> get props => [status, uid];
}

