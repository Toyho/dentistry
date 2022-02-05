import 'package:customizable_space_bar/customizable_space_bar.dart';
import 'package:dentistry/resources/colors_res.dart';
import 'package:dentistry/user_state/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'messenger_bloc.dart';

class MessengerScreen extends StatelessWidget {
  MessengerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userState = context
        .read<UserBloc>()
        .state;

    return BlocProvider<MessengerBloc>(
      create: (context) =>
      MessengerBloc()
        ..add(GetUsers())..add(GetMessage(userState.userUID)),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0.0,
              pinned: true,
              automaticallyImplyLeading: false,
              actions: [
                BlocBuilder<MessengerBloc, MessengerState>(
                  builder: (context, state) {
                    return IconButton(
                        onPressed: () {
                          context.read<MessengerBloc>().add(CreateChat(userState.userUID, userState.userAvatar, "${userState.name} ${userState.lastName}"));
                        },
                        icon: Icon(
                          Icons.add,
                          color: Theme
                              .of(context)
                              .iconTheme
                              .color,
                        ));
                  },
                )
              ],
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
            BlocBuilder<MessengerBloc, MessengerState>(
              builder: (context, state) {
                switch (state.getUsersStatus) {
                  case GetUsersStatus.initial:
                    return const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()));
                  case GetUsersStatus.success:
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          // if (index.isEven && state.users!.users!.length != 1) {
                          //   return const Padding(
                          //     padding: EdgeInsets.symmetric(horizontal: 20),
                          //     child: Divider(height: 0, color: Colors.grey),
                          //   );
                          // }
                          return Container(
                            child: TextButton(
                              child: Row(
                                children: <Widget>[
                                  Material(
                                    child: Image.network(
                                      userState.isAdmin! ? state.chats![index]['userAvatar'] : state.chats![index]['userAvatar'],
                                      fit: BoxFit.cover,
                                      width: 50,
                                      height: 50,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Container(
                                          width: 50,
                                          height: 50,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                  .expectedTotalBytes !=
                                                  null &&
                                                  loadingProgress
                                                      .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                                  : null,
                                            ),
                                          ),
                                        );
                                      },
                                      errorBuilder:
                                          (context, object, stackTrace) {
                                        return Icon(
                                          Icons.account_circle,
                                          size: 50,
                                          color: Colors.grey,
                                        );
                                      },
                                    ),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                    clipBehavior: Clip.hardEdge,
                                  ),
                                  Flexible(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                                userState.isAdmin! ? state.chats![index]['userName1'] : state.chats![index]['userName2'],
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .headline6),
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.fromLTRB(
                                                10, 0, 0, 10),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                    state.chats![index]
                                                    ['lastMsg'],
                                                    maxLines: 1,
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                    style: Theme
                                                        .of(context)
                                                        .textTheme
                                                        .subtitle1),
                                                Text(
                                                  DateFormat('kk:mm').format(
                                                      (state.chats![index]
                                                      ['lastTime'])
                                                          .toDate()),
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .subtitle1,
                                                )
                                              ],
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                            ),
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.fromLTRB(
                                                10, 0, 0, 5),
                                          ),
                                        ],
                                      ),
                                      margin: EdgeInsets.only(left: 4),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                print(state.chats![index].id);
                                Navigator.pushNamed(context,
                                    "/detail_messenger_screen|${state
                                        .chats![index].id}");
                              },
                            ),
                            margin:
                            EdgeInsets.only(bottom: 10, left: 4, right: 4),
                          );
                        },
                        childCount: state.chats!.length,
                      ),
                    );
                  case GetUsersStatus.failure:
                    return const SliverToBoxAdapter(child: Center());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
