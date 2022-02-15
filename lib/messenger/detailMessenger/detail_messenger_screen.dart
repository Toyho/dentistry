import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentistry/user_state/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'detail_messenger_bloc.dart';

class DetailMessengerScreen extends StatelessWidget {
  DetailMessengerScreen({this.idChat, this.name, this.avatar, Key? key})
      : super(key: key);
  String? idChat;
  String? name;
  String? avatar;

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userState = context.read<UserBloc>().state;
    var localText = AppLocalizations.of(context)!;

    return BlocProvider<DetailMessengerBloc>(
      create: (context) => DetailMessengerBloc()..add(GetMessages(idChat)),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(avatar!),
                    maxRadius: 20,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          name!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Online",
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            BlocBuilder<DetailMessengerBloc, DetailMessengerState>(
                builder: (context, state) {
              switch (state.getMessagesStatus) {
                case GetMessagesStatus.initial:
                  return const CircularProgressIndicator();
                case GetMessagesStatus.empty:
                  return Expanded(
                    child: Center(
                      child: Text(localText.sendYourFirstMessage),
                    ),
                  );
                case GetMessagesStatus.success:
                  var messages = state.listMessages!.docs;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: messages.length,
                      reverse: true,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        DocumentSnapshot messagesItem = messages[index];
                        return Container(
                          padding: EdgeInsets.only(
                              left: 14, right: 14, top: 10, bottom: 10),
                          child: Align(
                            alignment: (messagesItem['uid'] == userState.userUID
                                ? Alignment.topRight
                                : Alignment.topLeft),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (messagesItem['uid'] == userState.userUID
                                    ? Colors.blue[200]
                                    : Colors.grey.shade200),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Text(
                                messagesItem['msg'],
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                case GetMessagesStatus.fail:
                  return Center(
                    child: Text(localText.isFailed),
                  );
              }
              return CircularProgressIndicator();
            }),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.color,
                    border: Border.all(color: Colors.black)),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                            hintText: localText.writeMessage,
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    BlocBuilder<DetailMessengerBloc, DetailMessengerState>(
                      builder: (context, state) {
                        return FloatingActionButton(
                          onPressed: () {
                            context.read<DetailMessengerBloc>().add(SendMessage(
                                msg: textEditingController.text,
                                chatID: idChat,
                                uid: userState.userUID));
                            textEditingController.clear();
                          },
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18,
                          ),
                          backgroundColor: Colors.blue,
                          elevation: 0,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
