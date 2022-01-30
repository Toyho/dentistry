part of 'doctors_bloc.dart';

enum GetDoctorsStatus {initial, success, failure, empty}

class DoctorsState extends Equatable {
  const DoctorsState({
    this.status = GetDoctorsStatus.initial,
    this.doctors
  });

  final GetDoctorsStatus status;
  final DoctorsList? doctors;


  DoctorsState copyWith({
    GetDoctorsStatus? status,
    DoctorsList? doctos,
  }) {
    return DoctorsState(
      status: status ?? this.status,
      doctors: doctos ?? this.doctors,
    );
  }

  @override
  List<Object?> get props => [status, doctors];
}

