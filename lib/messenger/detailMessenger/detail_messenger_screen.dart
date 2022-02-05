import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentistry/resources/colors_res.dart';
import 'package:dentistry/user_state/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class DetailMessengerScreen extends StatelessWidget {
  DetailMessengerScreen(String this.idChat, {Key? key}) : super(key: key);
  String? idChat;

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userState = context.read<UserBloc>().state;

    return Scaffold(
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
                  backgroundImage: NetworkImage(
                      "https://i.pinimg.com/736x/ef/83/c3/ef83c388247b4c5784e2ae9cea604fd2.jpg"),
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
                        "Kriss Benwat",
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
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .doc(idChat)
                  .collection("messages")
                  .orderBy('created', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isNotEmpty) {
                    print(snapshot.data!.docs[0].data());
                    List<DocumentSnapshot> items = snapshot.data!.docs;
                    print(items);
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        reverse: true,
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          DocumentSnapshot ds = snapshot.data!.docs[index];
                          return Container(
                            padding: EdgeInsets.only(
                                left: 14, right: 14, top: 10, bottom: 10),
                            child: Align(
                              alignment: (ds['uid'] == userState.userUID
                                  ? Alignment.topRight
                                  : Alignment.topLeft),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (ds['uid'] == userState.userUID
                                      ? Colors.blue[200]
                                      : Colors.grey.shade200),
                                ),
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  ds['msg'],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Center(
                        child: Text("Напишите ваше первое сообщение"),
                      ),
                    );
                  }
                } else {
                  return CircularProgressIndicator();
                }
              }),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
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
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('messages')
                          .doc(idChat)
                          .collection("messages")
                          .add({
                        'msg': textEditingController.text,
                        'created': FieldValue.serverTimestamp(),
                        'uid': userState.userUID
                      });
                      FirebaseFirestore.instance
                          .collection('messages')
                          .doc(idChat)
                          .update({
                        'lastTime': FieldValue.serverTimestamp(),
                        'lastMsg': textEditingController.text
                      });
                      textEditingController.clear();
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
