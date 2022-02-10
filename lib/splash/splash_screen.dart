import 'dart:async';

import 'package:dentistry/resources/colors_res.dart';
import 'package:dentistry/user_state/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(seconds: 2), (){
      if (context.read<UserBloc>().state.isAuth ?? false) {
        Navigator.pushReplacementNamed(context, "/main_screen");
      } else {
        Navigator.pushReplacementNamed(context, "/auth_screen");
      }
    });

    return Scaffold(
      body: Center(
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
      );
  }
}
