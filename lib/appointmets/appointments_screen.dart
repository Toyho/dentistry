import 'package:customizable_space_bar/customizable_space_bar.dart';
import 'package:dentistry/settings/settings_bloc.dart';
import 'package:dentistry/user_state/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'appointments_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userState = context.read<UserBloc>().state;
    var localText = AppLocalizations.of(context)!;

    return BlocProvider<AppointmentsBloc>(
      create: (context) =>
          AppointmentsBloc()..add(GetAppointments(userState.userUID!)),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0.0,
              pinned: true,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context,
                          "/create_appointment_screen|${userState.name}|${userState.lastName}|${userState.patronymic}|${userState.passport}");
                    },
                    icon: Icon(
                      Icons.add_to_photos_outlined,
                      color: Theme.of(context).iconTheme.color,
                    ))
              ],
              flexibleSpace: CustomizableSpaceBar(
                builder: (context, scrollingRate) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: 13, left: 12 + 40 * scrollingRate),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        localText.appointments,
                        style: TextStyle(
                            fontSize: 42 - 18 * scrollingRate,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
              expandedHeight: 130,
            ),
            BlocBuilder<AppointmentsBloc, AppointmentsState>(
              builder: (context, state) {
                switch (state.getAppointmentsStatus) {
                  case GetAppointmentsStatus.initial:
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  case GetAppointmentsStatus.fail:
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Text("Произошла ошибка"),
                      ),
                    );
                  case GetAppointmentsStatus.success:
                    return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                      return BlocListener<AppointmentsBloc, AppointmentsState>(
                        listener: (context, state) {
                          switch (state.deleteAppointmentsStatus) {
                            case DeleteAppointmentsStatus.success:
                              // Navigator.of(context).pop();
                              break;
                          }
                        },
                        child: GestureDetector(
                          onLongPress: () {
                            Widget cancelButton = TextButton(
                              child: Text(localText.cancelText),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            );
                            Widget continueButton = TextButton(
                              child: Text(localText.continueText),
                              onPressed: () {
                                context.read<AppointmentsBloc>().add(
                                    DeleteAppointment(
                                        date: state.listAppointments![index]
                                            ['date'],
                                        time: state.listAppointments![index]
                                            ['time'],
                                        uidDoctor:
                                            state.listAppointments![index]
                                                ['uidDoctor'],
                                        service: state.listAppointments![index]
                                            ['service']));
                                Navigator.of(context).pop();
                              },
                            );
                            AlertDialog alert = AlertDialog(
                              title: Text(localText.deleteText),
                              content:
                                  Text(localText.wantToDeleteTheAppointment),
                              actions: [
                                cancelButton,
                                continueButton,
                              ],
                            );

                            // show the dialog
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alert;
                              },
                            );
                          },
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(state.listAppointments![index]
                                    ['fioDoctor']),
                                Text(state.listAppointments![index]['date']),
                                Text(state.listAppointments![index]['time']),
                              ],
                            ),
                          ),
                        ),
                      );
                    }, childCount: state.listAppointments!.length));
                  case GetAppointmentsStatus.empty:
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(localText.noAppointments),
                      ),
                    );
                }
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
