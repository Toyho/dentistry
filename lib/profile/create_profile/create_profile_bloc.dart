import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'create_profile_event.dart';

part 'create_profile_state.dart';

class CreateProfileBloc extends Bloc<CreateProfileEvent, CreateProfileState> {
  ImagePicker picker = ImagePicker();
  File? imagePick;
  File? croppedImage;

  final FirebaseDatabase _fb = FirebaseDatabase.instance;

  CreateProfileBloc() : super(const CreateProfileState()) {
    on<AddAvatarEvent>(_addAvatar);
    on<SaveInfoEvent>(_safeInfo);
  }

  Future<void> _safeInfo(
      SaveInfoEvent event, Emitter<CreateProfileState> emit) async {
    String? avatarUrl;

    Directory directory = await getApplicationDocumentsDirectory();
    var dbPath = p.join(directory.path, "image.png");
    ByteData data = await rootBundle.load("assets/images/defaultAvatar.png");
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var imageFile = await File(dbPath).writeAsBytes(bytes);

    if (event.currentAvatar == null || event.currentAvatar == "") {
      try {
        await firebase_storage.FirebaseStorage.instance
            .ref('${event.userUID!}Avatar')
            .putFile(
                state.avatarImage ?? imageFile,
                SettableMetadata(customMetadata: {
                  'uploaded_by': 'A bad guy',
                  'description': 'Some description...'
                }))
            .then((p0) => print(p0.state));
        await firebase_storage.FirebaseStorage.instance
            .ref('${event.userUID!}Avatar')
            .getDownloadURL()
            .then((value) => avatarUrl = value);
      } catch (e) {
        print(e);
      }
    } else {
      if (state.avatarImage == null) {
        avatarUrl = event.currentAvatar;
      } else {
        try {
          await firebase_storage.FirebaseStorage.instance
              .ref('${event.userUID!}Avatar')
              .putFile(
                  state.avatarImage!,
                  SettableMetadata(customMetadata: {
                    'uploaded_by': 'A bad guy',
                    'description': 'Some description...'
                  }))
              .then((p0) => print(p0.state));
          await firebase_storage.FirebaseStorage.instance
              .ref('${event.userUID!}Avatar')
              .getDownloadURL()
              .then((value) => avatarUrl = value);
        } catch (e) {
          print(e);
        }
      }
    }

    await _fb.ref().child("users").child(event.userUID!).update({
      "name": event.name,
      "lastName": event.lastName,
      "patronymic": event.patronymic,
      "dateOfBirth": event.dateOfBirth,
      "avatar": avatarUrl,
      "passport": event.passport,
      "uid": event.userUID!,
    }).whenComplete(() async {
      {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(event.userEmail)
            .update({
          'nickname': "${event.name} ${event.lastName}",
          'photoUrl': avatarUrl,
        });
      }
    });
    emit(state.copyWith(saveProfileState: SaveProfile.success));
  }

  Future<void> _addAvatar(
      AddAvatarEvent event, Emitter<CreateProfileState> emit) async {
    final XFile? pickerFile =
        await picker.pickImage(source: ImageSource.gallery);
    imagePick = File(pickerFile!.path);

    croppedImage = await ImageCropper.cropImage(
        sourcePath: imagePick!.path,
        maxWidth: 1080,
        maxHeight: 1080,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Редактирование',
            initAspectRatio: CropAspectRatioPreset.square,
            hideBottomControls: true,
            lockAspectRatio: true),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    emit(state.copyWith(avatarImage: croppedImage));
  }
}
