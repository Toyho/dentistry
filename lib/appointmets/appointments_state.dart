part of 'appointments_bloc.dart';

enum GetAppointmentsStatus {initial, fail, success, empty}

class AppointmentsState extends Equatable {

  const AppointmentsState({
    this.getAppointmentsStatus = GetAppointmentsStatus.initial,
    this.listAppointments
  });

  final GetAppointmentsStatus? getAppointmentsStatus;
  final List<QueryDocumentSnapshot<Object?>>? listAppointments;


  AppointmentsState copyWith({
    GetAppointmentsStatus? getAppointmentsStatus,
    List<QueryDocumentSnapshot<Object?>>? listAppointments,
  }) {
    return AppointmentsState(
      getAppointmentsStatus: getAppointmentsStatus ?? this.getAppointmentsStatus,
      listAppointments: listAppointments ?? this.listAppointments,
    );
  }

  @override
  List<Object?> get props => [getAppointmentsStatus, listAppointments];
}
