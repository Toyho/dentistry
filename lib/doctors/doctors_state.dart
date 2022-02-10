part of 'doctors_bloc.dart';

enum GetDentistsStatus { initial, success, failure, empty }
enum GetOrthopedistsStatus { initial, success, failure, empty }

class DoctorsState extends Equatable {
  const DoctorsState({this.getDentistsStatus = GetDentistsStatus.initial, this.getOrthopedistsStatus = GetOrthopedistsStatus.initial, this.dentists, this.orthopedists});

  final GetDentistsStatus getDentistsStatus;
  final GetOrthopedistsStatus getOrthopedistsStatus;
  final QuerySnapshot<Object?>? dentists;
  final QuerySnapshot<Object?>? orthopedists;

  DoctorsState copyWith({
    GetDentistsStatus? getDentistsStatus,
    GetOrthopedistsStatus? getOrthopedistsStatus,
    DoctorsList? doctos,
    QuerySnapshot<Object?>? dentists,
    QuerySnapshot<Object?>? orthopedists,
  }) {
    return DoctorsState(
      getDentistsStatus: getDentistsStatus ?? this.getDentistsStatus,
      getOrthopedistsStatus: getOrthopedistsStatus ?? this.getOrthopedistsStatus,
      dentists: dentists ?? this.dentists,
      orthopedists: orthopedists ?? this.orthopedists,
    );
  }

  @override
  List<Object?> get props => [getDentistsStatus, dentists, orthopedists, getOrthopedistsStatus];
}
