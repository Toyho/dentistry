import 'package:customizable_space_bar/customizable_space_bar.dart';
import 'package:dentistry/resources/colors_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

import 'appointments_bloc.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> _availableMinutes = [1, 4, 6, 8, 12];

    return BlocProvider<AppointmentsBloc>(
      create: (context) => AppointmentsBloc(),
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
                      // showCustomTimePicker(
                      //     context: context,
                      //     // It is a must if you provide selectableTimePredicate
                      //     onFailValidation: (context) => print('Unavailable selection'),
                      //     initialTime: TimeOfDay(hour: 1, minute: 0),
                      //     builder: (context, child) {
                      //       return MediaQuery(
                      //         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                      //         child: child!,
                      //       );
                      //     },
                      //     selectableTimePredicate: (time) => _availableMinutes.contains(time!.hour)).then((time) =>
                      //     print(time?.format(context)));
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
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ListTile(
                    title: Text("LIST ITEM"),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
