import 'dart:async';
import 'dart:io';
import 'package:dentistry/models/posts/post_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Stream streamPosts = FirebaseDatabase.instance.ref("posts").onValue;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  ImagePicker picker = ImagePicker();
  File? imagePick;
  File? croppedImage;

  HomeBloc() : super(const HomeState()) {
    on<GetPosts>(_getPosts);
    on<ChangeAvatar>(_changeAvatar);
  }

  Future<void> _getPosts(GetPosts event, Emitter<HomeState> emit) async {
    print("GetPostsEvent");
    await emit.onEach(streamPosts, onData: (_) {
      print(_);
      Post posts;
      DatabaseEvent snapshot = _ as DatabaseEvent;
      posts = Post.fromJson(snapshot.snapshot.value);
      emit(state.copyWith(status: PostStatus.success, posts: posts));
    });
  }

  Future<void> _changeAvatar(
      ChangeAvatar event, Emitter<HomeState> emit) async {
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
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Редактирование',
            // toolbarColor: ColorsRes.fromHex(ColorsRes.primaryColor),
            // toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            hideBottomControls: true,
            lockAspectRatio: true),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    try {
      await firebase_storage.FirebaseStorage.instance.ref('image').putFile(
          croppedImage!,
          SettableMetadata(customMetadata: {
            'uploaded_by': 'A bad guy',
            'description': 'Some description...'
          }));
      firebase_storage.FirebaseStorage.instance
          .ref('image')
          .getDownloadURL()
          .then((value) => print(value));
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
