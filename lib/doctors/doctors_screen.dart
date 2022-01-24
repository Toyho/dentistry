import 'package:customizable_space_bar/customizable_space_bar.dart';
import 'package:dentistry/resources/colors_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DoctorsScreen extends StatelessWidget {
  const DoctorsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, value) {
              return [
                SliverOverlapAbsorber (
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                    top: false,
                    sliver: SliverAppBar(
                      elevation: 0.0,
                      pinned: true,
                      backgroundColor: ColorsRes.fromHex(ColorsRes.whiteColor),
                      automaticallyImplyLeading: false,
                      flexibleSpace: CustomizableSpaceBar(
                        builder: (context, scrollingRate) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: 13, left: 12 + 40 * scrollingRate),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "Doctors",
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
                  delegate: MySliverPersistentHeaderDelegate(),
                  pinned: true,
                  floating: false,
                ),
              ];
            },
            body: TabBarView(
              children: [
                ListView.builder(
                    itemCount: 10,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, item) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            color: Colors.white),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              child: Image.network(
                                "https://i.pinimg.com/736x/ef/83/c3/ef83c388247b4c5784e2ae9cea604fd2.jpg",
                                height: 56,
                                width: 56,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Иванов Иван", style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600
                                  )),
                                  Text("Врач-стоматолог", style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600
                                  )),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                Center(
                  child: Text("34"),
                ),
              ],
            ),
          )),
    );
  }
}

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 48.0;

  @override
  double get maxExtent => 48.0;

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
        color: ColorsRes.fromHex(ColorsRes.whiteColor),
        child: const TabBar(
          labelColor: Colors.black,
          tabs: [
            Tab(text: "12"),
            Tab(text: "34"),
          ],
        ),
      );

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
