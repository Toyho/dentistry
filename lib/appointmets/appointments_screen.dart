import 'package:customizable_space_bar/customizable_space_bar.dart';
import 'package:dentistry/user_state/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'appointments_bloc.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userState = context.read<UserBloc>().state;

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
                      Navigator.pushNamed(
                          context, "/create_appointment_screen");
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
                        "Appointments",
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
                        delegate:
                            SliverChildBuilderDelegate((context, index) {
                              return Text(state.listAppointments![index]['fio']);
                            },
                            childCount: state.listAppointments!.length));
                  case GetAppointmentsStatus.empty:
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Text("Нет записей"),
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
