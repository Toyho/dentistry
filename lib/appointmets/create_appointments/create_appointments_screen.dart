import 'package:dentistry/resources/colors_res.dart';
import 'package:dentistry/user_state/user_bloc.dart';
import 'package:dentistry/widgets/custome_text_field.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

import 'create_appointments_bloc.dart';

class CreateAppointmentsScreen extends StatefulWidget {
  CreateAppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<CreateAppointmentsScreen> createState() =>
      _CreateAppointmentsScreenState();
}

class _CreateAppointmentsScreenState extends State<CreateAppointmentsScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController patronymicController = TextEditingController();

  TextEditingController passportController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  TextEditingController timeController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  DateTime selectedTime = DateTime.now();

  int? _index;
  String? _value;
  String? _value1;

  @override
  void initState() {
    _index = 0;
    _value = "dentists";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userState = context.read<UserBloc>().state;

    TimeOfDay? selectedHourAndMinute;

    nameController.text = userState.name!;
    lastNameController.text = userState.lastName!;
    patronymicController.text = userState.patronymic!;
    passportController.text = userState.passport!;

    return BlocProvider<CreateAppointmentsBloc>(
      create: (context) => CreateAppointmentsBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("123"),
        ),
        body: BlocBuilder<CreateAppointmentsBloc, CreateAppointmentsState>(
          builder: (context, state) {
            return Stepper(
              physics: ClampingScrollPhysics(),
              steps: [
                Step(
                    title: Text("Персональная информация"),
                    content: BlocListener<CreateAppointmentsBloc,
                        CreateAppointmentsState>(
                      listener: (context, state) {
                        if (state.getServicesStatus ==
                            GetServicesStatus.success) {
                          setState(() {
                            _value = state.listServices![0]['value'];
                            _index = _index! + 1;
                          });
                        }
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 35.0),
                            child: CustomeTextField(
                              hint: "Имя",
                              textController: nameController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 35.0),
                            child: CustomeTextField(
                              hint: "Фамилия",
                              textController: lastNameController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 35.0),
                            child: CustomeTextField(
                              hint: "Отчество",
                              textController: patronymicController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 35.0),
                            child: CustomeTextField(
                              inputFormatters: [
                                TextInputMask(mask: '9999 999999'),
                              ],
                              hint: "Паспортные данные",
                              textController: passportController,
                            ),
                          ),
                          SizedBox(
                            height: 56,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: AnimatedContainer(
                                width: MediaQuery.of(context).size.height,
                                height: 56,
                                duration: const Duration(milliseconds: 300),
                                child: RaisedButton(
                                  padding: const EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  color:
                                      ColorsRes.fromHex(ColorsRes.primaryColor),
                                  textColor: Colors.white,
                                  child: Text("Сохранить",
                                      style: const TextStyle(fontSize: 16)),
                                  onPressed: () async {
                                    context
                                        .read<CreateAppointmentsBloc>()
                                        .add(GetServices());
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                Step(
                  title: Text("Выбор направления"),
                  content: BlocListener<CreateAppointmentsBloc,
                          CreateAppointmentsState>(
                      listener: (context, state) {
                        if (state.getDoctorsStatus ==
                            GetDoctorsStatus.success) {
                          setState(() {
                            _value1 = state.listDoctors![0]['FIO'];
                            _index = _index! + 1;
                          });
                        }
                      },
                      child: Column(
                        children: [
                          state.listServices != null
                              ? DropdownButton<String>(
                                  items: state.listServices!
                                      .map((fc) => DropdownMenuItem<String>(
                                            child: Text(fc['name']),
                                            value: fc['value'],
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _value = value;
                                    });
                                  },
                                  value: _value,
                                  isExpanded: true,
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 56,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: AnimatedContainer(
                                width: MediaQuery.of(context).size.height,
                                height: 56,
                                duration: const Duration(milliseconds: 300),
                                child: RaisedButton(
                                  padding: const EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  color:
                                      ColorsRes.fromHex(ColorsRes.primaryColor),
                                  textColor: Colors.white,
                                  child: Text("Сохранить",
                                      style: const TextStyle(fontSize: 16)),
                                  onPressed: () async {
                                    context
                                        .read<CreateAppointmentsBloc>()
                                        .add(GetDoctors(_value));
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
                Step(
                  title: Text("Выбор врача"),
                  content: BlocConsumer<CreateAppointmentsBloc,
                      CreateAppointmentsState>(
                    listener: (context, state) {

                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          state.listDoctors != null
                              ? DropdownButton<String>(
                                  items: state.listDoctors!
                                      .map((fc) => DropdownMenuItem<String>(
                                            child: Text(fc['FIO']),
                                            value: fc['FIO'],
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _value1 = value;
                                    });
                                  },
                                  value: _value1,
                                  isExpanded: true,
                                )
                              : SizedBox(),
                          SizedBox(
                            height: 56,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: AnimatedContainer(
                                width: MediaQuery.of(context).size.height,
                                height: 56,
                                duration: const Duration(milliseconds: 300),
                                child: RaisedButton(
                                  padding: const EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  color:
                                      ColorsRes.fromHex(ColorsRes.primaryColor),
                                  textColor: Colors.white,
                                  child: Text("Сохранить",
                                      style: const TextStyle(fontSize: 16)),
                                  onPressed: () async {
                                    setState(() {
                                      _index = _index! + 1;
                                    });
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                Step(
                  title: Text("Выбор даты"),
                  content: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(bottom: 35.0),
                          child: TextField(
                            controller: dateController,
                            decoration: InputDecoration(
                              filled: true,
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              hintText: "День рождения",
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  final DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: selectedDate,
                                      firstDate: DateTime(2015, 8),
                                      lastDate: DateTime(2101),
                                      initialEntryMode:
                                          DatePickerEntryMode.input);
                                  String date =
                                      DateFormat('yyyy-MM-dd').format(picked!);
                                  dateController.text = date;
                                  context
                                      .read<CreateAppointmentsBloc>()
                                      .add(CheckDate(date: date, FIO: _value1, service: _value));
                                },
                                icon: Icon(Icons.calendar_today_outlined),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 56,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: AnimatedContainer(
                            width: MediaQuery.of(context).size.height,
                            height: 56,
                            duration: const Duration(milliseconds: 300),
                            child: RaisedButton(
                              padding: const EdgeInsets.all(16.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(12.0)),
                              color:
                              ColorsRes.fromHex(ColorsRes.primaryColor),
                              textColor: Colors.white,
                              child: Text("Сохранить",
                                  style: const TextStyle(fontSize: 16)),
                              onPressed: () async {
                                setState(() {
                                  _index = _index! + 1;
                                });
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Step(
                  title: Text("Выбор времени"),
                  content: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(bottom: 35.0),
                          child: TextField(
                            controller: timeController,
                            decoration: InputDecoration(
                              filled: true,
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(12))),
                              hintText: "День рождения",
                              suffixIcon: IconButton(
                                onPressed: () async {
                                  showCustomTimePicker(
                                      context: context,
                                      // It is a must if you provide selectableTimePredicate
                                      onFailValidation: (context) =>
                                          print('Unavailable selection'),
                                      initialTime:
                                      TimeOfDay(hour: 9, minute: 0),
                                      builder: (context, child) {
                                        return MediaQuery(
                                          data: MediaQuery.of(context)
                                              .copyWith(
                                              alwaysUse24HourFormat:
                                              true),
                                          child: child!,
                                        );
                                      },
                                      selectableTimePredicate: (time) =>
                                          state.listFreeTime.contains(
                                              time!.hour)).then((time) {
                                    timeController.text =
                                        time!.format(context);
                                    selectedHourAndMinute = time;
                                  });
                                },
                                icon: Icon(Icons.calendar_today_outlined),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 56,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: AnimatedContainer(
                            width: MediaQuery.of(context).size.height,
                            height: 56,
                            duration: const Duration(milliseconds: 300),
                            child: RaisedButton(
                              padding: const EdgeInsets.all(16.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(12.0)),
                              color:
                              ColorsRes.fromHex(ColorsRes.primaryColor),
                              textColor: Colors.white,
                              child: Text("Сохранить",
                                  style: const TextStyle(fontSize: 16)),
                              onPressed: () async {
                                context
                                    .read<CreateAppointmentsBloc>()
                                    .add(CreateAppointment(
                                      uidCreater: userState.userUID,
                                      name: nameController.text,
                                      lastName: lastNameController.text,
                                      patronymic: patronymicController.text,
                                      passport: passportController.text,
                                      date: dateController.text,
                                      time: selectedHourAndMinute,
                                      service: _value
                                    ));
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return SizedBox();
              },
              currentStep: _index!,
              // onStepTapped: (index) {
              //   setState(() {
              //     _index = index;
              //   });
              // },
            );
          },
        ),
      ),
    );
  }
}
