part of 'appointments_bloc.dart';

abstract class AppointmentsState extends Equatable {
  const AppointmentsState();
}

class AppointmentsInitial extends AppointmentsState {
  @override
  List<Object> get props => [];
}
