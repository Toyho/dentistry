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
    this.userUID,
    this.dateOfBirth,
    this.userEmail,
    this.currentAvatar,
  });

  final String? name;
  final String? lastName;
  final String? patronymic;
  final String? passport;
  final String? dateOfBirth;
  final String? userUID;
  final String? userEmail;
  final String? currentAvatar;

  @override
  List<Object?> get props =>
      [name, lastName, patronymic, passport, userUID, dateOfBirth, userEmail, currentAvatar];
}
