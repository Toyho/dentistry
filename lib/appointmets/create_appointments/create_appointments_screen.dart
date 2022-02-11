import 'package:dentistry/widgets/button_back.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dentistry/user_state/user_bloc.dart';
import 'package:dentistry/widgets/button_next.dart';
import 'package:dentistry/widgets/custome_text_field.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

import 'create_appointments_bloc.dart';

class CreateAppointmentsScreen extends StatefulWidget {
  CreateAppointmentsScreen({this.name, this.lastName, this.patronymic, this.passport, Key? key}) : super(key: key);

  String? name;
  String? lastName;
  String? patronymic;
  String? passport;

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
  String? selectedService;
  String? selectedDoctor;

  @override
  void initState() {
    _index = 0;
    nameController.text = widget.name!;
    lastNameController.text = widget.lastName!;
    patronymicController.text = widget.patronymic!;
    passportController.text = widget.passport!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userState = context.read<UserBloc>().state;
    var localText = AppLocalizations.of(context)!;

    TimeOfDay? selectedHourAndMinute;

    return BlocProvider<CreateAppointmentsBloc>(
      create: (context) => CreateAppointmentsBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            localText.createAppointment,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
        body: BlocBuilder<CreateAppointmentsBloc, CreateAppointmentsState>(
          builder: (context, state) {
            return Stepper(
              physics: ClampingScrollPhysics(),
              steps: [
                Step(
                    title: Text(localText.personalData),
                    content: BlocListener<CreateAppointmentsBloc,
                        CreateAppointmentsState>(
                      listener: (context, state) {
                        if (state.getServicesStatus ==
                            GetServicesStatus.success) {
                          setState(() {
                            selectedService = state.listServices![0]['value'];
                            _index = _index! + 1;
                          });
                        }
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 35.0),
                            child: CustomeTextField(
                              hint: localText.name,
                              textController: nameController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 35.0),
                            child: CustomeTextField(
                              hint: localText.lastName,
                              textController: lastNameController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 35.0),
                            child: CustomeTextField(
                              hint: localText.patronymic,
                              textController: patronymicController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 35.0),
                            child: CustomeTextField(
                              inputFormatters: [
                                TextInputMask(mask: '9999 999999'),
                              ],
                              hint: localText.passport,
                              textController: passportController,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: ButtonNext(
                                  isEnabled: state.isPersonalDataEnable,
                                  onPressed: () async {
                                    context
                                        .read<CreateAppointmentsBloc>()
                                        .add(GetServices());
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                Step(
                  title: Text(localText.choiceOfDirection),
                  content: BlocListener<CreateAppointmentsBloc,
                          CreateAppointmentsState>(
                      listener: (context, state) {
                        if (state.getDoctorsStatus ==
                            GetDoctorsStatus.success) {
                          setState(() {
                            selectedDoctor = state.listDoctors![0]['FIO'];
                            _index = _index! + 1;
                          });
                        }
                      },
                      child: Column(
                        children: [
                          state.listServices != null
                              ? DropdownButton<String>(
                                  items: state.listServices!
                                      .map((doctor) => DropdownMenuItem<String>(
                                            child: Text(doctor['name']),
                                            value: doctor['value'],
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedService = value;
                                    });
                                  },
                                  value: selectedService,
                                  isExpanded: true,
                                )
                              : SizedBox(),
                          Row(
                            children: [
                              Expanded(
                                child: ButtonBack(
                                  onPressed: () async {
                                    setState(() {
                                      _index = _index! - 1;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: ButtonNext(
                                  isEnabled: state.isChoiceOfDirectionEnable,
                                  onPressed: () async {
                                    context
                                        .read<CreateAppointmentsBloc>()
                                        .add(GetDoctors(selectedService));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
                Step(
                  title: Text(localText.doctorsChoice),
                  content: BlocConsumer<CreateAppointmentsBloc,
                      CreateAppointmentsState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return Column(
                        children: [
                          state.listDoctors != null
                              ? DropdownButton<String>(
                                  items: state.listDoctors!
                                      .map((doctor) => DropdownMenuItem<String>(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  margin: const EdgeInsets.only(
                                                      right: 8),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                            doctor['avatar'],
                                                          ))),
                                                ),
                                                Text(doctor['FIO']),
                                              ],
                                            ),
                                            value: doctor['FIO'],
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedDoctor = value;
                                    });
                                  },
                                  focusColor: Colors.red,
                                  itemHeight: 80,
                                  value: selectedDoctor,
                                  isExpanded: true,
                                )
                              : SizedBox(),
                          Row(
                            children: [
                              Expanded(
                                child: ButtonBack(
                                  onPressed: () async {
                                    setState(() {
                                      _index = _index! - 1;
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: ButtonNext(
                                  isEnabled: state.isChoiceOfDoctorEnable,
                                  onPressed: () async {
                                    setState(() {
                                      _index = _index! + 1;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Step(
                  title: Text(localText.datePicker),
                  content: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(bottom: 35.0),
                          child: TextField(
                            onChanged: (newDate) {
                              print(newDate.length);
                              context
                                  .read<CreateAppointmentsBloc>()
                                  .add(ValidationDate(newDate));
                            },
                            onTap: () async {
                              final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2101),
                                  initialEntryMode: DatePickerEntryMode.input);
                              String date =
                                  DateFormat('yyyy-MM-dd').format(picked!);
                              dateController.text = date;
                              context.read<CreateAppointmentsBloc>().add(
                                  CheckDate(
                                      date: date,
                                      FIO: selectedDoctor,
                                      service: selectedService));
                              context
                                  .read<CreateAppointmentsBloc>()
                                  .add(ValidationDate(date));
                            },
                            readOnly: true,
                            controller: dateController,
                            decoration: InputDecoration(
                              filled: true,
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              hintText: localText.receptionDay,
                              suffixIcon: Icon(Icons.calendar_today_outlined),
                            ),
                          )),
                      Row(
                        children: [
                          Expanded(
                            child: ButtonBack(
                              onPressed: () async {
                                setState(() {
                                  _index = _index! - 1;
                                });
                              },
                            ),
                          ),
                          Expanded(
                            child: ButtonNext(
                              isEnabled: state.isChoiceOfDateEnable,
                              onPressed: () async {
                                setState(() {
                                  _index = _index! + 1;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Step(
                  title: Text(localText.timePicker),
                  content: BlocListener<CreateAppointmentsBloc,
                      CreateAppointmentsState>(
                    listener: (context, state) {
                      switch (state.createAppointmentStatus) {
                        case CreateAppointmentStatus.success:
                          Navigator.pop(context);
                          break;
                      }
                    },
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(bottom: 35.0),
                            child: TextField(
                              onChanged: (newTime) {
                                print(newTime.length);
                                context
                                    .read<CreateAppointmentsBloc>()
                                    .add(ValidationTime(newTime));
                              },
                              onTap: () async {
                                showCustomTimePicker(
                                    context: context,
                                    onFailValidation: (context) =>
                                        print('Unavailable selection'),
                                    initialTime: TimeOfDay(
                                        hour: state.listFreeTime[0], minute: 0),
                                    builder: (context, child) {
                                      return MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                            alwaysUse24HourFormat: true),
                                        child: child!,
                                      );
                                    },
                                    selectableTimePredicate: (time) => state
                                        .listFreeTime
                                        .contains(time!.hour)).then((time) {
                                  timeController.text = time!.format(context);
                                  selectedHourAndMinute = time;
                                  context.read<CreateAppointmentsBloc>().add(
                                      ValidationTime(time.format(context)));
                                });
                              },
                              readOnly: true,
                              controller: timeController,
                              decoration: InputDecoration(
                                  filled: true,
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  hintText: localText.receptionFreeTime,
                                  suffixIcon: const Icon(
                                      Icons.calendar_today_outlined)),
                            )),
                        Row(
                          children: [
                            Expanded(
                              child: ButtonBack(
                                onPressed: () async {
                                  setState(() {
                                    _index = _index! - 1;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: ButtonNext(
                                isEnabled: state.isChoiceOfTimeEnable,
                                onPressed: () async {
                                  context.read<CreateAppointmentsBloc>().add(
                                      CreateAppointment(
                                          uidCreater: userState.userUID,
                                          name: nameController.text,
                                          lastName: lastNameController.text,
                                          patronymic: patronymicController.text,
                                          passport: passportController.text,
                                          date: dateController.text,
                                          time: selectedHourAndMinute,
                                          fioDoctor: selectedDoctor,
                                          service: selectedService));
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return SizedBox();
              },
              // controlsBuilder: (BuildContext context,
              //     {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
              //   return const SizedBox();
              // },
              currentStep: _index!,
            );
          },
        ),
      ),
    );
  }
}
