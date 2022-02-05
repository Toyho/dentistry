part of 'create_appointments_bloc.dart';

abstract class CreateAppointmentsEvent extends Equatable {
  const CreateAppointmentsEvent();
}

class CheckDate extends CreateAppointmentsEvent {
  CheckDate({this.date});

  String? date;

  @override
  List<Object?> get props => [date];
}

class CreateAppointment extends CreateAppointmentsEvent {
  CreateAppointment({
    this.uidCreater,
    this.name,
    this.lastName,
    this.patronymic,
    this.date,
    this.passport,
    this.time,
  });

  String? uidCreater;
  String? name;
  String? lastName;
  String? patronymic;
  String? date;
  String? passport;
  TimeOfDay? time;

  @override
  List<Object?> get props => [
        uidCreater,
        name,
        lastName,
        patronymic,
        date,
        passport,
        time,
      ];
}
