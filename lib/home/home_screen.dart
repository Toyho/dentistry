import 'dart:convert';

import 'package:customizable_space_bar/customizable_space_bar.dart';
import 'package:dentistry/google_map/google_map_screen.dart';
import 'package:dentistry/models/posts/post_model.dart';
import 'package:dentistry/resources/colors_res.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    final _advancedDrawerController = AdvancedDrawerController();

    return AdvancedDrawer(
      backdropColor: ColorsRes.fromHex(ColorsRes.primaryColor),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      drawer: Padding(
        padding: const EdgeInsets.symmetric(vertical: 54),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 65,
              backgroundImage: NetworkImage(
                  "https://i.pinimg.com/736x/ef/83/c3/ef83c388247b4c5784e2ae9cea604fd2.jpg"),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              "Ильин Илья",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: ColorsRes.fromHex(ColorsRes.whiteColor)),
            )
          ],
        ),
      ),
      child: Scaffold(
        body: StreamBuilder<DatabaseEvent>(
            stream: _database.child("posts").onValue,
            builder: (context, snapshot) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    elevation: 0.0,
                    pinned: true,
                    backgroundColor: ColorsRes.fromHex(ColorsRes.whiteColor),
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
                              color: ColorsRes.fromHex(ColorsRes.primaryColor),
                            ),
                          );
                        },
                      ),
                    ),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const GoogleMapScreen()));
                          },
                          icon: Icon(
                            Icons.location_on_outlined,
                            color: ColorsRes.fromHex(ColorsRes.primaryColor),
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
                              "Home",
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
                  snapshot.hasData
                      ? SliverList(
                          delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            Post posts;
                            posts = Post.fromJson(
                                (snapshot.data! as DatabaseEvent)
                                    .snapshot
                                    .value);
                            return Container(
                              margin: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  color: Colors.white),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16, bottom: 8, left: 8, right: 8),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                        child: Text(posts.posts![index].text
                                            as String)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Image.memory(base64Decode(
                                        posts.posts![index].image as String)),
                                  ),
                                ],
                              ),
                            );
                          },
                          childCount: 3,
                        ))
                      : SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator())),
                ],
              );
            }),
      ),
    );
  }
}
