import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState());

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> checkIsAuth() async {
    final SharedPreferences prefs = await _prefs;
    String? uid = prefs.getString('uid_account');
    Future.delayed(const Duration(seconds: 2), () {
      if (uid != null) {
        emit(state.copyWith(status: AuthCheckStatus.isAuth, uid: uid));
      } else {
        emit(state.copyWith(
          status: AuthCheckStatus.isNotAuth,
        ));
      }
    });
  }
}
