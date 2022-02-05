part of 'messenger_bloc.dart';

abstract class MessengerEvent extends Equatable {
  const MessengerEvent();
}

class GetUsers extends MessengerEvent {
  @override
  List<Object?> get props => [];

}

class GetMessage extends MessengerEvent {
  const GetMessage(this.userUID);

  final String? userUID;

  @override
  List<Object?> get props => [userUID];

}

class CreateChat extends MessengerEvent {
  const CreateChat(this.userUID, this.userAvatar, this.userName);

  final String? userUID;
  final String? userAvatar;
  final String? userName;

  @override
  List<Object?> get props => [userUID, userAvatar, userName];

}
