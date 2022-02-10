import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dentistry/models/doctors/doctors.dart';
import 'package:equatable/equatable.dart';

part 'doctors_event.dart';

part 'doctors_state.dart';

class DoctorsBloc extends Bloc<DoctorsEvent, DoctorsState> {
  Stream getDentists = FirebaseFirestore.instance.collection('doctors').doc('dentists').collection('doctors').snapshots();
  Stream getOrthopedists = FirebaseFirestore.instance.collection('doctors').doc('orthopedists').collection('doctors').snapshots();

  DoctorsBloc() : super(const DoctorsState()) {
    on<GetDentistsInfo>(_getDentistsInfo);
    on<GetOrthopedistsInfo>(_getOrthopedistsInfo);
  }

  Future<void> _getDentistsInfo(
      GetDentistsInfo event, Emitter<DoctorsState> emit) async {
    print("GetDentistsInfoEvent");
    try {
      await emit.onEach(getDentists, onData: (_) {
        var dentists = _ as QuerySnapshot;
        if (dentists.docs.isNotEmpty) {
          emit(state.copyWith(
              getDentistsStatus: GetDentistsStatus.success, dentists: dentists));
        } else {
          emit(state.copyWith(getDentistsStatus: GetDentistsStatus.empty));
        }
      });
    } catch (_) {
      emit(state.copyWith(getDentistsStatus: GetDentistsStatus.failure));
    }
  }

  Future<void> _getOrthopedistsInfo(
      GetOrthopedistsInfo event, Emitter<DoctorsState> emit) async {
    print("GetOrthopedistsInfoEvent");
    try {
      await emit.onEach(getOrthopedists, onData: (_) {
        print(_);
        var orthopedists = _ as QuerySnapshot;
        if (orthopedists.docs.isNotEmpty) {
          emit(state.copyWith(
              getOrthopedistsStatus: GetOrthopedistsStatus.success, orthopedists: orthopedists));
        } else {
          emit(state.copyWith(getOrthopedistsStatus: GetOrthopedistsStatus.empty));
        }
      });
    } catch (_) {
      emit(state.copyWith(getOrthopedistsStatus: GetOrthopedistsStatus.failure));
    }
  }
}
