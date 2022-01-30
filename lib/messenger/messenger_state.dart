part of 'messenger_bloc.dart';

enum GetUsersStatus { initial, success, failure }

@immutable
class MessengerState extends Equatable{

  const MessengerState({
    this.users,
    this.messages,
    this.getUsersStatus = GetUsersStatus.initial
  });

  final UsersList? users;
  final GetUsersStatus getUsersStatus;
  final MessagesList? messages;


  MessengerState copyWith({
    UsersList? users,
    GetUsersStatus? getUsersStatus,
    MessagesList? messages,
  }) {
    return MessengerState(
      users: users ?? this.users,
      messages: messages ?? this.messages,
      getUsersStatus: getUsersStatus ?? this.getUsersStatus,
    );
  }

  @override
  List<Object?> get props => [users, getUsersStatus];

}
