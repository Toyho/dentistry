import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'detail_messenger_event.dart';

part 'detail_messenger_state.dart';

class DetailMessengerBloc
    extends Bloc<DetailMessengerEvent, DetailMessengerState> {

  DetailMessengerBloc() : super(DetailMessengerState()) {
    on<GetMessages>(_getMessages);
    on<SendMessage>(_sendMessage);
  }

  Future<void> _getMessages(GetMessages event,
      Emitter<DetailMessengerState> emit) async {
    try {
     await emit.onEach(
          FirebaseFirestore.instance
              .collection('messages')
              .doc(event.chatID)
              .collection("messages")
              .orderBy('created', descending: true)
              .snapshots(), onData: (_) {
        var messages = _ as QuerySnapshot;
        if (messages.docs.isNotEmpty) {
          emit(state.copyWith(
              getMessagesStatus: GetMessagesStatus.success,
              listMessages: messages));
        } else {
          emit(state.copyWith(getMessagesStatus: GetMessagesStatus.empty));
        }
      });
    } catch (_) {
      emit(state.copyWith(getMessagesStatus: GetMessagesStatus.fail));
    }
  }

  Future<void> _sendMessage(SendMessage event, Emitter<DetailMessengerState> emit) async {
    if (event.msg != null && event.msg != "") {
      FirebaseFirestore.instance
          .collection('messages')
          .doc(event.chatID)
          .update({
        'lastTime': FieldValue.serverTimestamp(),
        'lastMsg': event.msg
      });
      FirebaseFirestore.instance
          .collection('messages')
          .doc(event.chatID)
          .collection("messages")
          .add({
        'msg': event.msg,
        'created': FieldValue.serverTimestamp(),
        'uid': event.uid
      });
    }

  }

}
