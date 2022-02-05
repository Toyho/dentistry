import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as cloud_firestore;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentistry/models/messages/messages_list.dart';
import 'package:dentistry/models/user/users.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

part 'messenger_event.dart';
part 'messenger_state.dart';

class MessengerBloc extends Bloc<MessengerEvent, MessengerState> {

  Stream streamPosts = FirebaseDatabase.instance.ref("users").onValue;


  MessengerBloc() : super(const MessengerState()) {
    on<GetUsers>(_getUsers);
    on<GetMessage>(_getMessages);
    on<CreateChat>(_createChat);
  }

  Future<void> _getUsers(GetUsers event, Emitter<MessengerState> emit) async {
    print("GetPostsEvent");
    await emit.onEach(streamPosts, onData: (_) {
      print(_);
      UsersList users;
      DatabaseEvent snapshot = _ as DatabaseEvent;
      users = UsersList.fromJson(snapshot.snapshot.value as Map<dynamic,dynamic>);
      print(users);
      emit(state.copyWith(users: users));
      // emit(state.copyWith(users: users, getUsersStatus: GetUsersStatus.success));
    });
  }

  Future<void> _createChat(CreateChat event, Emitter<MessengerState> emit) async {

    cloud_firestore.FirebaseFirestore.instance.collection('messages').add({
      'user1' : event.userUID,
      'user2' : "Q6twsqnTqpaWt96H9D48n0oAe1f2",
      'userName1' : event.userName,
      'userName2' : 'Администратор',
      'userAvatar' : event.userAvatar,
      'lastMsg' : "",
      'lastTime' : Timestamp.now()
    });

  }

  Future<void> _getMessages(GetMessage event, Emitter<MessengerState> emit) async {
    print("GetPostsEvent");
    cloud_firestore.QuerySnapshot<Object?> documentDataUser1;
    cloud_firestore.QuerySnapshot<Object?> documentDataUser2;
    await emit.onEach(cloud_firestore.FirebaseFirestore.instance.collection('messages').where('user1', isEqualTo: event.userUID).snapshots(), onData: (_) {
      print(_);
      documentDataUser1 = _ as cloud_firestore.QuerySnapshot;

      if(documentDataUser1.docs.isNotEmpty) {

        emit.onEach(cloud_firestore.FirebaseFirestore.instance.collection('messages').where('user2', isEqualTo: event.userUID).snapshots(), onData: (_) {
          documentDataUser2 = _ as cloud_firestore.QuerySnapshot;
          if(documentDataUser2.docs.isNotEmpty) {
            emit(state.copyWith(chats: documentDataUser1.docs..addAll(documentDataUser2.docs), getUsersStatus: GetUsersStatus.success));
          } else {
            emit(state.copyWith(chats: documentDataUser1.docs, getUsersStatus: GetUsersStatus.success));
          }
        });

      } else {
        emit.onEach(cloud_firestore.FirebaseFirestore.instance.collection('messages').where('user2', isEqualTo: event.userUID).snapshots(), onData: (_) {
          documentDataUser2 = _ as cloud_firestore.QuerySnapshot;
          if(documentDataUser2.docs.isNotEmpty) {
            emit(state.copyWith(chats: documentDataUser2.docs, getUsersStatus: GetUsersStatus.success));
          } else {
            emit(state.copyWith(getUsersStatus: GetUsersStatus.failure));
            print("No Chats");
          }
        });
      }
    });
  }

}
