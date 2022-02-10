part of 'appointments_bloc.dart';

abstract class AppointmentsEvent extends Equatable {
  const AppointmentsEvent();
}

class GetAppointments extends AppointmentsEvent {
  const GetAppointments(this.userUID);

  final String userUID;

  @override
  List<Object?> get props => [userUID];
}

class DeleteAppointment extends AppointmentsEvent {
  const DeleteAppointment({this.date, this.time, this.service, this.uidDoctor});

  final String? date;
  final String? time;
  final String? service;
  final String? uidDoctor;

  @override
  List<Object?> get props => [date, time, service, uidDoctor];
}
