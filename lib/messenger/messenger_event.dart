part of 'messenger_bloc.dart';

abstract class MessengerEvent extends Equatable {
  const MessengerEvent();
}

class GetUsers extends MessengerEvent {
  @override
  List<Object?> get props => [];

}

class GetMessage extends MessengerEvent {
  const GetMessage({this.userUID, this.isAdmin});

  final String? userUID;
  final bool? isAdmin;

  @override
  List<Object?> get props => [userUID, isAdmin];

}

class CreateChat extends MessengerEvent {
  const CreateChat(this.userUID, this.userAvatar, this.userName);

  final String? userUID;
  final String? userAvatar;
  final String? userName;

  @override
  List<Object?> get props => [userUID, userAvatar, userName];

}
