import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'create_appointments_event.dart';
part 'create_appointments_state.dart';

class CreateAppointmentsBloc extends Bloc<CreateAppointmentsEvent, CreateAppointmentsState> {
  CreateAppointmentsBloc() : super(CreateAppointmentsState()) {
    on<CheckDate>(_checkDate);
    on<CreateAppointment>(_createAppointment);
  }

  Future<void> _createAppointment(CreateAppointment event, Emitter<CreateAppointmentsState> emit) async {
    var index = state.listFreeTime;
    var index1 = index.remove(event.time!.hour);
    print(index);

    FirebaseFirestore.instance.collection('appointments').doc(event.date).collection(event.time!.hour.toString()).add({
      'uidCreater' : event.uidCreater,
      'fio' : '${event.lastName} ${event.name} ${event.patronymic}',
      'passport' : event.passport,
      'date' : event.date,
      'time' : '${event.time!.hour}:${event.time!.minute}',
    });

    FirebaseFirestore.instance.collection('appointments').doc(event.date).set(
      {
        'freeTime' : index
      }
    );

  }

  Future<void> _checkDate(CheckDate event, Emitter<CreateAppointmentsState> emit) async {

    try {
      var collectionRef = FirebaseFirestore.instance.collection('appointments');
      var doc = await collectionRef.doc(event.date).get();
      print(doc.exists);

      if (!doc.exists) {
        List<int> listTime = [9, 10, 11, 12, 13, 14, 15, 16, 17, 18];
        emit(state.copyWith(listFreeTime: listTime));
      } else {
        print(doc['freeTime']);
        emit(state.copyWith(listFreeTime: doc['freeTime'].cast<int>()));
      }

    } catch (e) {
      throw e;
    }

  }

}
