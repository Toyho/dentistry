part of 'detail_messenger_bloc.dart';

enum GetMessagesStatus { initial, empty, success, fail }

class DetailMessengerState extends Equatable {
  const DetailMessengerState({
    this.getMessagesStatus = GetMessagesStatus.initial,
    this.listMessages
  });

  final GetMessagesStatus? getMessagesStatus;
  final QuerySnapshot? listMessages;


  DetailMessengerState copyWith({
    GetMessagesStatus? getMessagesStatus,
    QuerySnapshot? listMessages,
  }) {
    return DetailMessengerState(
      getMessagesStatus: getMessagesStatus ?? this.getMessagesStatus,
      listMessages: listMessages ?? this.listMessages,
    );
  }


  @override
  List<Object?> get props => [getMessagesStatus, listMessages];
}

