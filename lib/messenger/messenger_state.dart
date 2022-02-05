part of 'messenger_bloc.dart';

enum GetUsersStatus { initial, success, failure }

@immutable
class MessengerState extends Equatable{

  const MessengerState({
    this.users,
    this.messages,
    this.chats,
    this.getUsersStatus = GetUsersStatus.initial
  });

  final UsersList? users;
  final GetUsersStatus getUsersStatus;
  final MessagesList? messages;
  final List<QueryDocumentSnapshot<Object?>>? chats;


  MessengerState copyWith({
    UsersList? users,
    GetUsersStatus? getUsersStatus,
    MessagesList? messages,
    List<QueryDocumentSnapshot<Object?>>? chats,
  }) {
    return MessengerState(
      users: users ?? this.users,
      messages: messages ?? this.messages,
      chats: chats ?? this.chats,
      getUsersStatus: getUsersStatus ?? this.getUsersStatus,
    );
  }

  @override
  List<Object?> get props => [users, getUsersStatus, chats];

}
