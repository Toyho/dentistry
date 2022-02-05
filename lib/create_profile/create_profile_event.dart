part of 'create_profile_bloc.dart';

abstract class CreateProfileEvent extends Equatable {
  const CreateProfileEvent();
}

class AddAvatarEvent extends CreateProfileEvent {
  const AddAvatarEvent();

  @override
  List<Object?> get props => [];
}

class SaveInfoEvent extends CreateProfileEvent {
  const SaveInfoEvent({
    this.name,
    this.lastName,
    this.patronymic,
    this.passport,
    this.user,
    this.dateOfBirth,
  });

  final String? name;
  final String? lastName;
  final String? patronymic;
  final String? passport;
  final String? dateOfBirth;
  final String? user;

  @override
  List<Object?> get props => [name, lastName, patronymic, passport, user, dateOfBirth];
}
