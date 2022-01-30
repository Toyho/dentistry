import 'package:customizable_space_bar/customizable_space_bar.dart';
import 'package:dentistry/resources/colors_res.dart';
import 'package:flutter/material.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0.0,
            pinned: true,
            automaticallyImplyLeading: false,
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
    );
  }
}