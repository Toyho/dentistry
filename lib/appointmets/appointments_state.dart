part of 'appointments_bloc.dart';

enum GetAppointmentsStatus {initial, fail, success, empty}
enum DeleteAppointmentsStatus {initial, fail, success}

class AppointmentsState extends Equatable {

  const AppointmentsState({
    this.getAppointmentsStatus = GetAppointmentsStatus.initial,
    this.deleteAppointmentsStatus = DeleteAppointmentsStatus.initial,
    this.listAppointments
  });

  final GetAppointmentsStatus? getAppointmentsStatus;
  final DeleteAppointmentsStatus? deleteAppointmentsStatus;
  final List<QueryDocumentSnapshot<Object?>>? listAppointments;


  AppointmentsState copyWith({
    GetAppointmentsStatus? getAppointmentsStatus,
    DeleteAppointmentsStatus? deleteAppointmentsStatus,
    List<QueryDocumentSnapshot<Object?>>? listAppointments,
  }) {
    return AppointmentsState(
      getAppointmentsStatus: getAppointmentsStatus ?? this.getAppointmentsStatus,
      deleteAppointmentsStatus: deleteAppointmentsStatus ?? this.deleteAppointmentsStatus,
      listAppointments: listAppointments ?? this.listAppointments,
    );
  }

  @override
  List<Object?> get props => [getAppointmentsStatus, listAppointments, deleteAppointmentsStatus];
}
