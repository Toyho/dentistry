import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'appointments_event.dart';

part 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  AppointmentsBloc() : super(const AppointmentsState()) {
    on<GetAppointments>(_getAppointments);
    on<DeleteAppointment>(_deleteAppointment);
  }

  Future<void> _deleteAppointment(
      DeleteAppointment event, Emitter<AppointmentsState> emit) async {
    // emit(state.copyWith(deleteAppointmentsStatus: DeleteAppointmentsStatus.initial));
    try {
      var collectionRef = await FirebaseFirestore.instance
          .collection('doctors')
          .doc(event.service)
          .collection('doctors')
          .doc(event.uidDoctor)
          .collection('freeTime')
          .doc(event.date);
      var doc = await collectionRef.get();
      List<int> freeTime = List<int>.from(doc['freeTime']);
      print(freeTime);
      var hour = event.time!.split(':');
      List<int> dataListAsInt = hour.map((data) => int.parse(data)).toList();
      freeTime.add(dataListAsInt[0]);
      print(freeTime);

      FirebaseFirestore.instance
          .collection('appointments')
          .where('date', isEqualTo: event.date)
          .where('time', isEqualTo: event.time)
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });

      FirebaseFirestore.instance
          .collection('doctors')
          .doc(event.service)
          .collection('doctors')
          .doc(event.uidDoctor)
          .collection('freeTime')
          .doc(event.date)
          .set({'freeTime': freeTime});
      emit(state.copyWith(deleteAppointmentsStatus: DeleteAppointmentsStatus.success));
    } catch (_) {
      emit(state.copyWith(deleteAppointmentsStatus: DeleteAppointmentsStatus.fail));
    }
  }

  Future<void> _getAppointments(
      GetAppointments event, Emitter<AppointmentsState> emit) async {
    QuerySnapshot<Object?> listAppointments;
    try {
      await emit.onEach(
          FirebaseFirestore.instance
              .collection('appointments')
              .where('uidCreater', isEqualTo: event.userUID)
              .snapshots(), onData: (_) {
        listAppointments = _ as QuerySnapshot;
        if (listAppointments.docs.isNotEmpty) {
          emit(state.copyWith(
              listAppointments: listAppointments.docs,
              getAppointmentsStatus: GetAppointmentsStatus.success));
        } else {
          emit(state.copyWith(
              getAppointmentsStatus: GetAppointmentsStatus.empty));
        }
      });
    } catch (_) {
      emit(state.copyWith(getAppointmentsStatus: GetAppointmentsStatus.fail));
    }
  }
}
