import 'dart:async';
import 'package:dentistry/models/posts/post_model.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Stream streamPosts = FirebaseDatabase.instance.ref("posts").onValue;

  HomeBloc() : super(const HomeState()) {
    on<Init>(_Init);
  }

  Future<void> _Init(Init event, Emitter<HomeState> emit) async {
    print("InitEvent");
    await emit.onEach(streamPosts, onData: (_) {
      print(_);
      Post posts;
      DatabaseEvent snapshot = _ as DatabaseEvent;
      posts = Post.fromJson(snapshot.snapshot.value);
      emit(state.copyWith(status: PostStatus.success, posts: posts));
    });
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
