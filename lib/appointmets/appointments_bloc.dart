import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'appointments_event.dart';

part 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  AppointmentsBloc() : super(const AppointmentsState()) {
    on<GetAppointments>(_getAppointments);
  }

  Future<void> _getAppointments(
      GetAppointments event, Emitter<AppointmentsState> emit) async {
    QuerySnapshot<Object?> listAppointments;
    try {
      await emit.onEach(
          FirebaseFirestore.instance
              .collection('appointments')
              .where('uidCreater', isEqualTo: 'Q6twsqnTqpaWt96H9D48n0oAe1f2')
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
