import 'package:dentistry/auth/auth_screen.dart';
import 'package:dentistry/main/main_screen.dart';
import 'package:dentistry/messenger/detailMessenger/detail_messenger_screen.dart';
import 'package:dentistry/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {

  Widget _leftSideTransitionScreen(BuildContext context,
      Animation animation, Animation secondaryAnimation, Widget child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    var curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final offsetAnimation = animation.drive(tween);
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
  Widget _rightSideTransitionScreen(BuildContext context,
      Animation animation, Animation secondaryAnimation, Widget child) {
    const begin = Offset(-1.0, 0.0);
    const end = Offset.zero;
    var curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final offsetAnimation = animation.drive(tween);
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

  Route? onGenerateRoute(RouteSettings routeSettings) {
    var path = routeSettings.name!;

    switch (path) {
      case "/":
        {
          return MaterialPageRoute(
            builder: (_) => const SplashScreen(),
          );
        }
      case "/main_screen":
        {
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
            const MainScreen(),
            transitionDuration: Duration(milliseconds: 700),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                _leftSideTransitionScreen(
                    context, animation, secondaryAnimation, child),
            settings: routeSettings,
          );
        }
      case "/detail_messenger_screen":
        {
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
            DetailMessengerScreen(),
            transitionDuration: Duration(milliseconds: 700),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                _leftSideTransitionScreen(
                    context, animation, secondaryAnimation, child),
            settings: routeSettings,
          );
        }
      case "/auth_screen":
        {
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
            const AuthScreen(),
            transitionDuration: Duration(milliseconds: 700),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                _leftSideTransitionScreen(
                    context, animation, secondaryAnimation, child),
            settings: routeSettings,
          );
        }
      // case "/secondScreen":
      //   {
      //     return MaterialPageRoute(
      //       builder: (_) => BlocProvider.value(
      //         value: _secondBloc,
      //         child: const SecondScreen(),
      //       ),
      //     );
      //   }
      default:
        return null;
    }
  }

  void disposeSecondBloc() {

  }

}
