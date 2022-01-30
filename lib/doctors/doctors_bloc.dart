import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dentistry/models/doctors/doctors.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';

part 'doctors_event.dart';

part 'doctors_state.dart';

class DoctorsBloc extends Bloc<DoctorsEvent, DoctorsState> {
  Stream streamPosts = FirebaseDatabase.instance.ref("doctors/dentists").onValue;

  DoctorsBloc() : super(const DoctorsState()) {
    on<GetDoctorsInfo>(_getDoctorsInfo);
  }

  Future<void> _getDoctorsInfo(
      GetDoctorsInfo event, Emitter<DoctorsState> emit) async {
    print("GetDoctorsInfoEvent");
    try {
      await emit.onEach(streamPosts, onData: (_) {
        print(_);
        DoctorsList doctorsList;
        DatabaseEvent snapshot = _ as DatabaseEvent;
        doctorsList = DoctorsList.fromJson(snapshot.snapshot.value);
        if (doctorsList.doctors!.isNotEmpty) {
          emit(state.copyWith(
              status: GetDoctorsStatus.success, doctos: doctorsList));
        } else {
          emit(state.copyWith(status: GetDoctorsStatus.empty));
        }
      });
    } catch (_) {
      emit(state.copyWith(status: GetDoctorsStatus.failure));
    }
  }
}
