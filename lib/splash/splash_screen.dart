import 'dart:async';

import 'package:dentistry/auth/auth_screen.dart';
import 'package:dentistry/resources/colors_res.dart';
import 'package:dentistry/splash/viewModel/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (context) => SplashCubit()..checkIsAuth(),
      child: Scaffold(
        body: BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            switch(state.status){
              case AuthCheckStatus.isAuth:
                Navigator.pushReplacementNamed(context, "/main_screen");
                break;
              case AuthCheckStatus.isNotAuth:
                Navigator.pushReplacementNamed(context, "/auth_screen");
                break;
            }
          },
          child: Center(
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  SizedBox(
                      height: 220,
                      width: 220,
                      child: CircularProgressIndicator(
                        strokeWidth: 12,
                        color: ColorsRes.fromHex(ColorsRes.primaryColor),
                      )),
                  Hero(
                      tag: "1",
                      child: Image.asset(
                        "assets/images/main_logo.png",
                        width: 250,
                        height: 250,
                      ))
                ],
              )),
        ),
      ),
    );
  }
}
