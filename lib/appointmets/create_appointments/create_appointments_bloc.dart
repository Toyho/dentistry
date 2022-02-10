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
    on<GetServices>(_getService);
    on<GetDoctors>(_getDoctors);
    on<ValidationDate>(_validationDate);
    on<ValidationTime>(_validationTime);
  }

  Future<void> _validationTime(ValidationTime event, Emitter<CreateAppointmentsState> emit) async {
    var hourAndMinute = event.newTime!.split(':');

    if(hourAndMinute[0].length == 1 || hourAndMinute[0].length == 2 && hourAndMinute[1].length == 2) {
      emit(state.copyWith(isChoiceOfTimeEnable: true));
    } else {
      emit(state.copyWith(isChoiceOfTimeEnable: false));
    }

  }

  Future<void> _validationDate(ValidationDate event, Emitter<CreateAppointmentsState> emit) async {
    if(event.newDate!.length == 10) {
      emit(state.copyWith(isChoiceOfDateEnable: true));
    } else {
      emit(state.copyWith(isChoiceOfDateEnable: false));
    }

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

    try{
      FirebaseFirestore.instance.collection('appointments').add({
        'uidCreater' : event.uidCreater,
        'fio' : '${event.lastName} ${event.name} ${event.patronymic}',
        'passport' : event.passport,
        'date' : event.date,
        'time' : '${event.time!.hour}:${event.time!.minute}',
        'fioDoctor' : event.fioDoctor,
        'uidDoctor' : state.idDoctor,
        'service' : event.service,
      });

      FirebaseFirestore.instance.collection('doctors').doc(event.service).collection('doctors').doc(state.idDoctor).collection('freeTime').doc(event.date).set(
          {
            'freeTime' : index
          }
      );

      emit(state.copyWith(createAppointmentStatus: CreateAppointmentStatus.success));

    } catch(_){
      emit(state.copyWith(createAppointmentStatus: CreateAppointmentStatus.fail));
    }

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
        emit(state.copyWith(listFreeTime: listTime, idDoctor: documents));
      } else {
        print(doc['freeTime']);
        emit(state.copyWith(listFreeTime: doc['freeTime'].cast<int>(), idDoctor: documents));
      }

    } catch (e) {
      throw e;
    }

  }

}
