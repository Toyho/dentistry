part of 'messenger_bloc.dart';

abstract class MessengerEvent extends Equatable {
  const MessengerEvent();
}

class GetUsers extends MessengerEvent {
  @override
  List<Object?> get props => [];

}

class GetMessage extends MessengerEvent {
  @override
  List<Object?> get props => [];

}
