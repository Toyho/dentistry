part of 'create_appointments_bloc.dart';

enum GetServicesStatus {initial, empty, success, fail}
enum GetDoctorsStatus {initial, empty, success, fail}

class CreateAppointmentsState extends Equatable {

  CreateAppointmentsState({
    this.listFreeTime = const [],
    this.listServices,
    this.listDoctors,
    this.getServicesStatus = GetServicesStatus.initial,
    this.getDoctorsStatus = GetDoctorsStatus.initial,
    this.idDoctor
  });

  final List<int> listFreeTime;
  final List<QueryDocumentSnapshot<Object?>>? listServices;
  final List<QueryDocumentSnapshot<Object?>>? listDoctors;
  final GetServicesStatus getServicesStatus;
  final GetDoctorsStatus getDoctorsStatus;
  final String? idDoctor;


  CreateAppointmentsState copyWith({
    List<int>? listFreeTime,
    List<QueryDocumentSnapshot<Object?>>? listServices,
    List<QueryDocumentSnapshot<Object?>>? listDoctors,
    GetServicesStatus? getServicesStatus,
    GetDoctorsStatus? getDoctorsStatus,
    String? idDoctor,
  }) {
    return CreateAppointmentsState(
      listFreeTime: listFreeTime ?? this.listFreeTime,
      listServices: listServices ?? this.listServices,
      listDoctors: listDoctors ?? this.listDoctors,
      getServicesStatus: getServicesStatus ?? this.getServicesStatus,
      getDoctorsStatus: getDoctorsStatus ?? this.getDoctorsStatus,
      idDoctor: idDoctor ?? this.idDoctor,
    );
  }

  @override
  List<Object?> get props => [listFreeTime, listServices, listDoctors, getServicesStatus, getDoctorsStatus, idDoctor];
}
