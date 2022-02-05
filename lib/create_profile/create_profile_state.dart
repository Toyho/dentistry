part of 'create_profile_bloc.dart';

enum SaveProfile {initial, success, fail}

class CreateProfileState extends Equatable {
  const CreateProfileState({
    this.avatarImage,
    this.name,
    this.lastName,
    this.patronymic,
    this.passport,
    this.saveProfileState = SaveProfile.initial,
  });

  final File? avatarImage;
  final String? name;
  final String? lastName;
  final String? patronymic;
  final String? passport;
  final SaveProfile? saveProfileState;


  CreateProfileState copyWith({
    File? avatarImage,
    String? name,
    String? lastName,
    String? patronymic,
    String? passport,
    SaveProfile? saveProfileState,
  }) {
    return CreateProfileState(
      avatarImage: avatarImage ?? this.avatarImage,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      patronymic: patronymic ?? this.patronymic,
      passport: passport ?? this.passport,
      saveProfileState: saveProfileState ?? this.saveProfileState,
    );
  }

  @override
  List<Object?> get props => [avatarImage, name, lastName, patronymic, passport, saveProfileState];
}

