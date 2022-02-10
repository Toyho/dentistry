import 'package:dentistry/resources/colors_res.dart';
import 'package:dentistry/resources/images_res.dart';
import 'package:dentistry/user_state/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/src/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../settings_bloc.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userState = context.read<UserBloc>().state;
    var settingsBloc = context.read<SettingsBloc>();
    var localText = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(localText.settings),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: settingsBloc.state.themeInfo == "light"
                ? Icon(LineIcons.sun)
                : Icon(LineIcons.moon),
            color: Theme.of(context).iconTheme.color,
            onPressed: () {
              settingsBloc.add(CurrentAppTheme());
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                return Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: ColorsRes.fromHex(ColorsRes.primaryColor),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context,
                          "/change_profile_screen|${state.name}|${state.lastName}|${state.patronymic}|${state.passport}|${state.dateOfBirth}");
                      context.read<UserBloc>().add(OverwritingUserInfo());
                    },
                    title: Text(
                      '${state.name} ${state.lastName}',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          state.userAvatar!),
                    ),
                    trailing: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10.0),
            Card(
              elevation: 4.0,
              margin: const EdgeInsets.fromLTRB(32.0, 8.0, 32.0, 16.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(
                      Icons.lock_outline,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    title: Text(localText.changePassword),
                    trailing: Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      context.read<UserBloc>().add(OverwritingUserInfo());
                    },
                  ),
                  _buildDivider(),
                  BlocListener<SettingsBloc, SettingsState>(
                    listener: (context, state) {},
                    child: ListTile(
                      leading: Icon(
                        Icons.language,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      title: Text(localText.changeLanguage),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      onTap: () {
                        settingsBloc.add(ChangeLocalization());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
