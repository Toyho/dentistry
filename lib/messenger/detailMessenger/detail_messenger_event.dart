part of 'detail_messenger_bloc.dart';

abstract class DetailMessengerEvent extends Equatable {
  const DetailMessengerEvent();
}

class GetMessages extends DetailMessengerEvent {
  GetMessages(this.chatID);

  String? chatID;

  @override
  List<Object?> get props => [chatID];
}

class SendMessage extends DetailMessengerEvent {
  SendMessage({this.chatID, this.uid, this.msg});

  String? chatID;
  String? msg;
  String? uid;

  @override
  List<Object?> get props => [chatID, msg, uid];
}
