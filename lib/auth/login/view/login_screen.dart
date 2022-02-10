import 'dart:ui';

import 'package:dentistry/auth/login/viewModel/login_bloc.dart';
import 'package:dentistry/resources/colors_res.dart';
import 'package:dentistry/widgets/custome_text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dentistry/user_state/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:overlay_support/overlay_support.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var localText = AppLocalizations.of(context)!;

    return BlocProvider<LoginBloc>(
      create: (_) => LoginBloc(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            // ignore: missing_enum_constant_in_switch
            switch (state.status) {
              case LoginStatus.failure:
                switch (state.errorInfo?.code) {
                  case "invalid-email":
                    showSimpleNotification(
                        Text("The email address is badly formatted"),
                        background: Colors.redAccent);
                    break;
                  case "user-not-found":
                    showSimpleNotification(
                        Text(
                            "There is no user record corresponding to this identifier. The user may have been deleted"),
                        background: Colors.redAccent);
                    break;
                  case "wrong-password":
                    showSimpleNotification(
                        Text(
                            "The password is invalid or the user does not have a password"),
                        background: Colors.redAccent);
                    break;
                  case "unknown":
                    showSimpleNotification(
                        Text(state.errorInfo?.message as String),
                        background: Colors.redAccent);
                    break;
                  default:
                    showSimpleNotification(
                        Text(state.errorInfo?.message as String),
                        background: Colors.redAccent);
                }
                break;
              case LoginStatus.validFailure:
                showSimpleNotification(Text(state.errorValid as String),
                    background: Colors.redAccent);
                break;
              case LoginStatus.success:
                context.read<UserBloc>().add(AuthUser(user: state.user, isAuth: true));
                Future.delayed(Duration(seconds: 1), () async {
                  Navigator.pushReplacementNamed(context, "/main_screen");
                });
            }
          },
          builder: (context, state) {
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        color: Colors.black.withOpacity(0.5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  localText.login,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 32),
                                )),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomeTextField(
                              textController: emailController,
                              hint: localText.email,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomeTextField(
                              obscureText: true,
                              textController: passwordController,
                              hint: localText.password,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              height: 56,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: AnimatedContainer(
                                  width: state.status == LoginStatus.loading
                                      ? 56
                                      : MediaQuery.of(context).size.height,
                                  height: 56,
                                  duration: const Duration(milliseconds: 300),
                                  child: RaisedButton(
                                    padding: const EdgeInsets.all(16.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    color: ColorsRes.fromHex(
                                        ColorsRes.primaryColor),
                                    textColor: Colors.white,
                                    child: state.status == LoginStatus.loading
                                        ? const SizedBox(
                                            height: 48,
                                            width: 48,
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.white),
                                              value: null,
                                              strokeWidth: 1.0,
                                            ),
                                          )
                                        : Text(localText.continueText,
                                            style:
                                                const TextStyle(fontSize: 16)),
                                    onPressed: () {
                                      context.read<LoginBloc>().add(
                                          SignInWithEmailAndPassword(
                                              email: emailController.text
                                                  .replaceAll(" ", ""),
                                              password:
                                                  passwordController.text));
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Center(
                              child: Text(
                                localText.or,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ))),
                                onPressed: () {},
                                child: SizedBox(
                                  height: 56,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/google_logo.svg",
                                        height: 32,
                                        width: 32,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24),
                                        child: Text(
                                          localText.continueWithGoogle,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  localText.dontHaveAnAccount,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                const SizedBox(width: 10.0),
                                GestureDetector(
                                  onTap: () {
                                    TabController? controller =
                                        DefaultTabController.of(context);
                                    controller?.animateTo(1);
                                  },
                                  child: Text(
                                    localText.registration,
                                    style: TextStyle(
                                      color: ColorsRes.fromHex(
                                          ColorsRes.primaryColor),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: () {},
                                child: Text(
                                  localText.forgotYourPassword,
                                  style: TextStyle(
                                    color: ColorsRes.fromHex(
                                        ColorsRes.primaryColor),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
