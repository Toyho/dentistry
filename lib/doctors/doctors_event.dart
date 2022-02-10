part of 'doctors_bloc.dart';

abstract class DoctorsEvent extends Equatable {}

class GetDentistsInfo extends DoctorsEvent {
  @override
  List<Object?> get props => [];
}

class GetOrthopedistsInfo extends DoctorsEvent {
  @override
  List<Object?> get props => [];
}
