import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:dentistry/appointmets/appointments_screen.dart';
import 'package:dentistry/doctors/doctors_screen.dart';
import 'package:dentistry/home/home_screen.dart';
import 'package:dentistry/messenger/messenger_screen.dart';
import 'package:dentistry/resources/colors_res.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {

    var localText = AppLocalizations.of(context)!;

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          HomeScreen(),
          AppointmentsScreen(),
          MessengerScreen(),
          DoctorsScreen(),
          Center(
            child: Text("5"),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() {
          pageController.jumpToPage(index);
          _currentIndex = index;
        }),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text(AppLocalizations.of(context)!.home),
            activeColor: ColorsRes.fromHex(ColorsRes.primaryColor),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            title: Text(localText.appointments),
            activeColor: ColorsRes.fromHex(ColorsRes.primaryColor),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.message),
            title: Text(localText.messages),
            activeColor: ColorsRes.fromHex(ColorsRes.primaryColor),
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.medical_services),
            title: Text(localText.doctors),
            activeColor: ColorsRes.fromHex(ColorsRes.primaryColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
