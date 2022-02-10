import 'package:customizable_space_bar/customizable_space_bar.dart';
import 'package:dentistry/doctors/doctors_bloc.dart';
import 'package:dentistry/settings/settings_bloc.dart';
import 'package:dentistry/settings/theme/app_themes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var localText = AppLocalizations.of(context)!;

    return BlocProvider<DoctorsBloc>(
      create: (context) => DoctorsBloc()..add(GetDentistsInfo())..add(GetOrthopedistsInfo()),
      child: Scaffold(
        body: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (context, value) {
                return [
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverSafeArea(
                      top: false,
                      sliver: SliverAppBar(
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
                                  localText.doctors,
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
                    ),
                  ),
                  SliverPersistentHeader(
                    delegate: MySliverPersistentHeaderDelegate(localText.dentists, localText.orthopedists),
                    pinned: true,
                    floating: false,
                  ),
                ];
              },
              body: TabBarView(
                children: [
                  BlocBuilder<DoctorsBloc, DoctorsState>(
                    builder: (context, state) {
                      switch (state.getDentistsStatus) {
                        case GetDentistsStatus.initial:
                          return const Center(
                              child: CircularProgressIndicator());
                        case GetDentistsStatus.failure:
                          return const Center(
                              child: Text("Ошибка получения данных"));
                        case GetDentistsStatus.empty:
                          return const Center(
                              child: Text("Нет данных о докторах"));
                        case GetDentistsStatus.success:
                          return ListView.builder(
                              itemCount: state.dentists!.docs.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, item) {
                                return Container(
                                  padding: const EdgeInsets.all(20),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        context.read<SettingsBloc>().state.currentTheme == lightTheme ?
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ) : BoxShadow(),
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      color: Theme.of(context).cardColor),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16)),
                                        child: Image.network(state.dentists!.docs[item]['avatar'],
                                          height: 56,
                                          width: 56,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                                state.dentists!.docs[item]['FIO'],
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text(state.dentists!.docs[item]['profession'],
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                      }
                    },
                  ),
                  BlocBuilder<DoctorsBloc, DoctorsState>(
                    builder: (context, state) {
                      switch (state.getOrthopedistsStatus) {
                        case GetOrthopedistsStatus.initial:
                          return const Center(
                              child: CircularProgressIndicator());
                        case GetOrthopedistsStatus.failure:
                          return const Center(
                              child: Text("Ошибка получения данных"));
                        case GetOrthopedistsStatus.empty:
                          return const Center(
                              child: Text("Нет данных о докторах"));
                        case GetOrthopedistsStatus.success:
                          return ListView.builder(
                              itemCount: state.orthopedists!.docs.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, item) {
                                return Container(
                                  padding: const EdgeInsets.all(20),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        context.read<SettingsBloc>().state.currentTheme == lightTheme ?
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ) : BoxShadow(),
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                      color: Theme.of(context).cardColor),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(16)),
                                        child: Image.network(state.orthopedists!.docs[item]['avatar'],
                                          height: 56,
                                          width: 56,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                                state.orthopedists!.docs[item]['FIO'],
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Text(state.orthopedists!.docs[item]['profession'],
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                      }
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  MySliverPersistentHeaderDelegate(this.dentists, this.orthopedists);
  String? dentists;
  String? orthopedists;

  @override
  double get minExtent => 48.0;

  @override
  double get maxExtent => 48.0;

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
        color: Theme.of(context).appBarTheme.backgroundColor,
        child: TabBar(
          tabs: [
            Tab(text: dentists!),
            Tab(text: orthopedists!),
          ],
        ),
      );

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
