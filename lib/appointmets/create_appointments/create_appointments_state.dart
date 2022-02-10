part of 'create_appointments_bloc.dart';

enum GetServicesStatus { initial, empty, success, fail }
enum GetDoctorsStatus { initial, empty, success, fail }
enum CreateAppointmentStatus { initial, success, fail }

class CreateAppointmentsState extends Equatable {
  CreateAppointmentsState({
    this.listFreeTime = const [],
    this.listServices,
    this.listDoctors,
    this.getServicesStatus = GetServicesStatus.initial,
    this.getDoctorsStatus = GetDoctorsStatus.initial,
    this.createAppointmentStatus = CreateAppointmentStatus.initial,
    this.idDoctor,
    this.isPersonalDataEnable = true,
    this.isChoiceOfDirectionEnable = true,
    this.isChoiceOfDoctorEnable = true,
    this.isChoiceOfDateEnable = false,
    this.isChoiceOfTimeEnable = false,
  });

  final List<int> listFreeTime;
  final List<QueryDocumentSnapshot<Object?>>? listServices;
  final List<QueryDocumentSnapshot<Object?>>? listDoctors;
  final GetServicesStatus getServicesStatus;
  final GetDoctorsStatus getDoctorsStatus;
  final CreateAppointmentStatus createAppointmentStatus;
  final String? idDoctor;

  bool isPersonalDataEnable;
  bool isChoiceOfDirectionEnable;
  bool isChoiceOfDoctorEnable;
  bool isChoiceOfDateEnable;
  bool isChoiceOfTimeEnable;

  CreateAppointmentsState copyWith({
    List<int>? listFreeTime,
    List<QueryDocumentSnapshot<Object?>>? listServices,
    List<QueryDocumentSnapshot<Object?>>? listDoctors,
    GetServicesStatus? getServicesStatus,
    GetDoctorsStatus? getDoctorsStatus,
    CreateAppointmentStatus? createAppointmentStatus,
    String? idDoctor,
    bool? isPersonalDataEnable,
    bool? isChoiceOfDirectionEnable,
    bool? isChoiceOfDoctorEnable,
    bool? isChoiceOfDateEnable,
    bool? isChoiceOfTimeEnable,
  }) {
    return CreateAppointmentsState(
      listFreeTime: listFreeTime ?? this.listFreeTime,
      listServices: listServices ?? this.listServices,
      listDoctors: listDoctors ?? this.listDoctors,
      getServicesStatus: getServicesStatus ?? this.getServicesStatus,
      getDoctorsStatus: getDoctorsStatus ?? this.getDoctorsStatus,
      createAppointmentStatus:
          createAppointmentStatus ?? this.createAppointmentStatus,
      idDoctor: idDoctor ?? this.idDoctor,
      isPersonalDataEnable: isPersonalDataEnable ?? this.isPersonalDataEnable,
      isChoiceOfDirectionEnable:
          isChoiceOfDirectionEnable ?? this.isChoiceOfDirectionEnable,
      isChoiceOfDoctorEnable:
          isChoiceOfDoctorEnable ?? this.isChoiceOfDoctorEnable,
      isChoiceOfDateEnable: isChoiceOfDateEnable ?? this.isChoiceOfDateEnable,
      isChoiceOfTimeEnable: isChoiceOfTimeEnable ?? this.isChoiceOfTimeEnable,
    );
  }

  @override
  List<Object?> get props => [
        listFreeTime,
        listServices,
        listDoctors,
        getServicesStatus,
        getDoctorsStatus,
        createAppointmentStatus,
        idDoctor,
        isPersonalDataEnable,
        isChoiceOfDirectionEnable,
        isChoiceOfDoctorEnable,
        isChoiceOfDateEnable,
        isChoiceOfTimeEnable
      ];
}
