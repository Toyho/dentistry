import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentistry/models/messages/messages_list.dart';
import 'package:dentistry/models/user/users.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'messenger_event.dart';
part 'messenger_state.dart';

class MessengerBloc extends Bloc<MessengerEvent, MessengerState> {

  Stream streamPosts = FirebaseDatabase.instance.ref("users").onValue;


  MessengerBloc() : super(const MessengerState()) {
    on<GetUsers>(_getUsers);
    on<GetMessage>(_getMessages);
  }

  Future<void> _getUsers(GetUsers event, Emitter<MessengerState> emit) async {
    print("GetPostsEvent");
    await emit.onEach(streamPosts, onData: (_) {
      print(_);
      UsersList users;
      DatabaseEvent snapshot = _ as DatabaseEvent;
      users = UsersList.fromJson(snapshot.snapshot.value as Map<dynamic,dynamic>);
      print(users);
      emit(state.copyWith(users: users, getUsersStatus: GetUsersStatus.success));
    });
  }

  Future<void> _getMessages(GetMessage event, Emitter<MessengerState> emit) async {
    print("GetPostsEvent");
    // FirebaseFirestore.instance
    //     .collection('messages')
    //     .doc("111").collection("111")
    //     .add({
    //   'mess': "Привет",
    //   'date': DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
    //   'id': "Q6twsqnTqpaWt96H9D48n0oAe1f2"
    // });
    await emit.onEach(FirebaseFirestore.instance.collection('users').snapshots(), onData: (_) {
      print(_);
      var documentData = _ as QuerySnapshot;
      print(documentData.docs[0].data());
      // DatabaseEvent snapshot = _ as DatabaseEvent;
      // messages = MessagesList.fromJson(snapshot.snapshot.value);
      // print(messages);
      // emit(state.copyWith(messages: _, getUsersStatus: GetUsersStatus.success));
    });
  }

}
