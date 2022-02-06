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
