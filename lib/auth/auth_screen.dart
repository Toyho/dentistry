import 'package:dentistry/auth/singup/view/singup_screen.dart';
import 'package:flutter/material.dart';

import 'login/view/login_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> animation;
  bool isShowIndicator = false;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = Tween(begin: 0.0, end: 1.0).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        const Duration(microseconds: 500), () => animationController.forward());
    return Container(
        color: Theme.of(context).appBarTheme.backgroundColor,
        child: Stack(
          children: [
            Hero(
              tag: "1",
              child: Container(
                  constraints: const BoxConstraints.expand(),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/main_logo.png"),
                      alignment: Alignment(-0.6, 0),
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            FadeTransition(
              opacity: animation,
              child: DefaultTabController(
                  length: 2,
                  child: Builder(
                      builder: (BuildContext context) => TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                LoginScreen(),
                                SingupScreen(),
                              ]))),
            ),
          ],
        ));
  }
}
