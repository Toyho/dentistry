part of 'create_appointments_bloc.dart';

class CreateAppointmentsState extends Equatable {

  CreateAppointmentsState({
    this.listFreeTime = const [],

  });

  final List<int> listFreeTime;


  CreateAppointmentsState copyWith({
    List<int>? listFreeTime,
  }) {
    return CreateAppointmentsState(
      listFreeTime: listFreeTime ?? this.listFreeTime,
    );
  }

  @override
  List<Object> get props => [listFreeTime];
}
