import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

part 'create_appointments_event.dart';
part 'create_appointments_state.dart';

class CreateAppointmentsBloc extends Bloc<CreateAppointmentsEvent, CreateAppointmentsState> {
  CreateAppointmentsBloc() : super(CreateAppointmentsState()) {
    on<CheckDate>(_checkDate);
    on<CreateAppointment>(_createAppointment);
    on<GetServices>(_getService);
    on<GetDoctors>(_getDoctors);
  }

  Future<void> _getDoctors(GetDoctors event, Emitter<CreateAppointmentsState> emit) async {
    emit(state.copyWith(getDoctorsStatus: GetDoctorsStatus.initial, getServicesStatus: GetServicesStatus.initial));
    try{
      await FirebaseFirestore.instance.collection('doctors').doc(event.service).collection('doctors').get().then((value) {
        print(value);
        emit(state.copyWith(listDoctors: value.docs, getDoctorsStatus: GetDoctorsStatus.success));
      });
    } catch(_) {

    }

  }

  Future<void> _getService(GetServices event, Emitter<CreateAppointmentsState> emit) async {
    emit(state.copyWith(getServicesStatus: GetServicesStatus.initial));
    try{
      await FirebaseFirestore.instance.collection('services').get().then((value) {
        print(value);
        emit(state.copyWith(listServices: value.docs, getServicesStatus: GetServicesStatus.success));
      });
    } catch(_) {

    }

  }

  Future<void> _createAppointment(CreateAppointment event, Emitter<CreateAppointmentsState> emit) async {
    var index = state.listFreeTime;
    index.remove(event.time!.hour);
    print(index);

    FirebaseFirestore.instance.collection('appointments').add({
      'uidCreater' : event.uidCreater,
      'fio' : '${event.lastName} ${event.name} ${event.patronymic}',
      'passport' : event.passport,
      'date' : event.date,
      'time' : '${event.time!.hour}:${event.time!.minute}',
      'fioDoctor' : event.fioDoctor,
    });

    FirebaseFirestore.instance.collection('doctors').doc(event.service).collection('doctors').doc(state.idDoctor).collection('freeTime').doc(event.date).set(
      {
        'freeTime' : index
      }
    );

  }

  Future<void> _checkDate(CheckDate event, Emitter<CreateAppointmentsState> emit) async {

    emit(state.copyWith(getDoctorsStatus: GetDoctorsStatus.initial));

    try {
      var collectionRef1 = await FirebaseFirestore.instance.collection('doctors').doc(event.service).collection('doctors').where('FIO', isEqualTo: event.FIO).get();
      final String documents = collectionRef1.docs[0].id;

      var collectionRef = await FirebaseFirestore.instance.collection('doctors').doc(event.service).collection('doctors').doc(documents).collection('freeTime').doc(event.date);

      var doc = await collectionRef.get();
      print(doc.exists);

      if (!doc.exists) {
        List<int> listTime = [9, 10, 11, 12, 13, 14, 15, 16, 17, 18];
        emit(state.copyWith(listFreeTime: listTime));
      } else {
        print(doc['freeTime']);
        emit(state.copyWith(listFreeTime: doc['freeTime'].cast<int>(), idDoctor: documents));
      }

    } catch (e) {
      throw e;
    }

  }

}
