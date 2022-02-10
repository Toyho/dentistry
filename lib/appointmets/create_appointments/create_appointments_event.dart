part of 'create_appointments_bloc.dart';

abstract class CreateAppointmentsEvent extends Equatable {
  const CreateAppointmentsEvent();
}

class CheckDate extends CreateAppointmentsEvent {
  CheckDate({
    this.date,
    this.FIO,
    this.service,
  });

  String? date;
  String? FIO;
  String? service;

  @override
  List<Object?> get props => [date, FIO, service];
}

class GetServices extends CreateAppointmentsEvent {
  const GetServices();

  @override
  List<Object?> get props => [];
}

class GetDoctors extends CreateAppointmentsEvent {
  GetDoctors(this.service);

  String? service;

  @override
  List<Object?> get props => [service];
}

class ValidationDate extends CreateAppointmentsEvent {
  ValidationDate(this.newDate);

  String? newDate;

  @override
  List<Object?> get props => [newDate];
}
class ValidationTime extends CreateAppointmentsEvent {
  ValidationTime(this.newTime);

  String? newTime;

  @override
  List<Object?> get props => [newTime];
}

class CreateAppointment extends CreateAppointmentsEvent {
  CreateAppointment({
    this.uidCreater,
    this.name,
    this.lastName,
    this.patronymic,
    this.date,
    this.passport,
    this.service,
    this.fioDoctor,
    this.time,
  });

  String? uidCreater;
  String? name;
  String? lastName;
  String? patronymic;
  String? date;
  String? passport;
  String? service;
  String? fioDoctor;
  TimeOfDay? time;

  @override
  List<Object?> get props => [
        uidCreater,
        name,
        lastName,
        patronymic,
        date,
        passport,
        service,
        fioDoctor,
        time,
      ];
}
