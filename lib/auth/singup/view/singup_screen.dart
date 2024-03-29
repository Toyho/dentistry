import 'dart:ui';

import 'package:dentistry/auth/singup/viewModel/singup_bloc.dart';
import 'package:dentistry/resources/colors_res.dart';
import 'package:dentistry/user_state/user_bloc.dart';
import 'package:dentistry/widgets/custome_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SingupScreen extends StatelessWidget {
  SingupScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {

    var localText = AppLocalizations.of(context)!;

    return BlocProvider<SingupBloc>(
      create: (context) => SingupBloc(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              TabController? controller = DefaultTabController.of(context);
              controller?.animateTo(0);
            },
          ),
        ),
        body: BlocConsumer<SingupBloc, SingupState>(
          listener: (context, state) {
            switch (state.status) {
              case SingupStatus.success:
                showSimpleNotification(
                    const Text("Вы успешно зарегистрировались!"),
                    background: Colors.lightGreen);
                    context.read<UserBloc>().add(AddUserInfo(user: state.user));
                    Navigator.pushNamed(context, "/create_profile_screen");
                break;
              case SingupStatus.failure:
                switch (state.errorInfo?.code) {
                  case "invalid-email":
                    showSimpleNotification(
                        const Text("The email address is badly formatted"),
                        background: Colors.redAccent);
                    break;
                  case "user-not-found":
                    showSimpleNotification(
                        const Text(
                            "There is no user record corresponding to this identifier. The user may have been deleted"),
                        background: Colors.redAccent);
                    break;
                  case "wrong-password":
                    showSimpleNotification(
                        const Text(
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
              case SingupStatus.validFailure:
                showSimpleNotification(Text(state.errorValid as String),
                    background: Colors.redAccent);
                break;
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
                                  localText.singUp,
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
                            // TextField(
                            //   controller: emailController,
                            //   decoration: InputDecoration(
                            //     filled: true,
                            //     fillColor: Colors.white,
                            //     focusColor:
                            //         ColorsRes.fromHex(ColorsRes.primaryColor),
                            //     border: const OutlineInputBorder(
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(12))),
                            //     hintText: localText.email,
                            //   ),
                            // ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomeTextField(
                              textController: passwordController,
                              hint: localText.password,
                              obscureText: true,
                            ),
                            // TextField(
                            //   obscureText: true,
                            //   controller: passwordController,
                            //   decoration: InputDecoration(
                            //     filled: true,
                            //     fillColor: Colors.white,
                            //     focusColor:
                            //         ColorsRes.fromHex(ColorsRes.primaryColor),
                            //     border: const OutlineInputBorder(
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(12))),
                            //     hintText: localText.password,
                            //   ),
                            // ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomeTextField(
                              textController: confirmPasswordController,
                              hint: localText.repeatPassword,
                              obscureText: true,
                            ),
                            // TextField(
                            //   obscureText: true,
                            //   controller: confirmPasswordController,
                            //   decoration: InputDecoration(
                            //     filled: true,
                            //     fillColor: Colors.white,
                            //     focusColor:
                            //         ColorsRes.fromHex(ColorsRes.primaryColor),
                            //     border: const OutlineInputBorder(
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(12))),
                            //     hintText: localText.repeatPassword,
                            //   ),
                            // ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text.rich(TextSpan(children: [
                              TextSpan(
                                  text: localText.privacyAndPolicy1,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              TextSpan(
                                  text: localText.privacyAndPolicy2,
                                  style: TextStyle(
                                      color: ColorsRes.fromHex(
                                          ColorsRes.primaryColor),
                                      fontSize: 16))
                            ])),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              height: 56,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: AnimatedContainer(
                                  width: state.status == SingupStatus.loading
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
                                    child: state.status == SingupStatus.loading
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
                                        : Text(localText.makeSingUp,
                                            style:
                                                const TextStyle(fontSize: 16)),
                                    onPressed: () {
                                      context.read<SingupBloc>().add(
                                          SignUpWithEmailAndPassword(
                                              email: emailController.text
                                                  .replaceAll(" ", ""),
                                              password: passwordController.text,
                                              confirmPassword:
                                                  confirmPasswordController
                                                      .text));
                                    },
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
