import 'package:customizable_space_bar/customizable_space_bar.dart';
import 'package:dentistry/resources/colors_res.dart';
import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  const MessengerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
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
                      "Messages",
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
              (BuildContext context, int index) {
                if (index.isEven) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Divider(height: 0, color: Colors.grey),
                  );
                }
                return Container(
                  child: TextButton(
                    child: Row(
                      children: <Widget>[
                        Material(
                          child: Image.network(
                            "https://i.pinimg.com/736x/ef/83/c3/ef83c388247b4c5784e2ae9cea604fd2.jpg",
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: 50,
                                height: 50,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                                null &&
                                            loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, object, stackTrace) {
                              return Icon(
                                Icons.account_circle,
                                size: 50,
                                color: Colors.grey,
                              );
                            },
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          clipBehavior: Clip.hardEdge,
                        ),
                        Flexible(
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: [
                                      Text("Иванов Иван",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                      Text("10:30 am", style: TextStyle(color: Colors.black54),)
                                    ],
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                  ),
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                                ),
                                Container(
                                  child: Text("Приииииивееееет!!!!!",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      )),
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                )
                              ],
                            ),
                            margin: EdgeInsets.only(left: 20),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {},
                    // style: ButtonStyle(
                    //   backgroundColor:
                    //       MaterialStateProperty.all<Color>(Colors.grey),
                    //   shape: MaterialStateProperty.all<OutlinedBorder>(
                    //     RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.all(Radius.circular(10)),
                    //     ),
                    //   ),
                    // ),
                  ),
                  margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                );
                // Container(
                //   padding: const EdgeInsets.all(16),
                //   child: Row(
                //     children: [
                //       ClipRRect(
                //         borderRadius:
                //             const BorderRadius.all(Radius.circular(20)),
                //         child: Image.network(
                //           "https://i.pinimg.com/736x/ef/83/c3/ef83c388247b4c5784e2ae9cea604fd2.jpg",
                //           height: 56,
                //           width: 56,
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(left: 20),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Row(
                //               children: const [
                //                 Text("Иванов Иван",
                //                     style: TextStyle(
                //                         fontSize: 18,
                //                         fontWeight: FontWeight.w600)),
                //                 Text("10:30 am")
                //               ],
                //             ),
                //             Text("Врач-стоматолог",
                //                 style: TextStyle(
                //                   fontSize: 14,
                //                   color: Colors.black54,
                //                 )),
                //           ],
                //         ),
                //       )
                //     ],
                //   ),
                //   );
              },
              childCount: 21,
            ),
          ),
        ],
      ),
    );
  }
}
