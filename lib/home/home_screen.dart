import 'package:customizable_space_bar/customizable_space_bar.dart';
import 'package:dentistry/google_map/google_map_screen.dart';
import 'package:dentistry/resources/colors_res.dart';
import 'package:dentistry/settings/settings_bloc.dart';
import 'package:dentistry/settings/theme/app_themes.dart';
import 'package:dentistry/user_state/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _advancedDrawerController = AdvancedDrawerController();

    final userState = context.read<UserBloc>().state;
    var localText = AppLocalizations.of(context)!;

    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc()..add(GetPosts()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return AdvancedDrawer(
            controller: _advancedDrawerController,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            animateChildDecoration: true,
            backdropColor: Theme.of(context).primaryColor,
            rtlOpening: false,
            disabledGestures: false,
            childDecoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            drawer: Padding(
              padding: const EdgeInsets.symmetric(vertical: 54),
              child: Column(
                children: [
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      return CircleAvatar(
                        radius: 65,
                        backgroundImage: NetworkImage(state.userAvatar!),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      return Container(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text(
                          state.name! + " " + state.lastName!,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: ColorsRes.fromHex(ColorsRes.whiteColor)),
                        ),
                      );
                    },
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, "/settings_screen");
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 14),
                      child: Row(children: [
                        Icon(
                          Icons.settings,
                          color: ColorsRes.fromHex(ColorsRes.whiteColor),
                        ),
                        SizedBox(width: 10.0),
                        Text(localText.settings,
                            style: TextStyle(fontSize: 20)),
                        Spacer(),
                      ]),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.read<UserBloc>().add(DeleteUserInfo());
                      Navigator.pushReplacementNamed(context, "/sing_out");
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 14),
                      child: Row(children: [
                        Icon(
                          Icons.logout,
                          color: ColorsRes.fromHex(ColorsRes.whiteColor),
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          localText.singOut,
                          style: TextStyle(fontSize: 20),
                        ),
                        Spacer(),
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    elevation: 0.0,
                    pinned: true,
                    automaticallyImplyLeading: false,
                    leading: IconButton(
                      onPressed: () => _advancedDrawerController.showDrawer(),
                      icon: ValueListenableBuilder<AdvancedDrawerValue>(
                        valueListenable: _advancedDrawerController,
                        builder: (_, value, __) {
                          return AnimatedSwitcher(
                            duration: Duration(milliseconds: 250),
                            child: Icon(
                              value.visible ? Icons.clear : Icons.menu,
                              key: ValueKey<bool>(value.visible),
                              color: Theme.of(context).iconTheme.color,
                            ),
                          );
                        },
                      ),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            PackageInfo.fromPlatform()
                                .then((value) => print(value.version));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const GoogleMapScreen()));
                          },
                          icon: Icon(
                            Icons.location_on_outlined,
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
                              localText.home,
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
                      return state.posts != null
                          ? Container(
                              margin: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    context
                                                .read<SettingsBloc>()
                                                .state
                                                .currentTheme ==
                                            lightTheme
                                        ? BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          )
                                        : BoxShadow(),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  color: Theme.of(context).cardColor),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16, bottom: 8, left: 8, right: 8),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(state.posts?.posts![index]
                                            .text as String)),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            "/photo_view_screen|${state.posts?.posts![index].image as String}");
                                      },
                                      child: Image.network(
                                          state.posts?.posts![index].image
                                              as String,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            height: 200,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.white,
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      context
                                                  .read<SettingsBloc>()
                                                  .state
                                                  .currentTheme ==
                                              lightTheme
                                          ? BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            )
                                          : BoxShadow(),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    color: Theme.of(context).cardColor),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 120,
                                        margin: EdgeInsets.only(
                                            top: 16,
                                            bottom: 8,
                                            left: 8,
                                            right: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                      ),
                                      Container(
                                        height: 200,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 8),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                    },
                    childCount:
                        state.posts != null ? state.posts?.posts!.length : 10,
                  )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
