import 'package:dentistry/create_profile/create_profile_bloc.dart';
import 'package:dentistry/resources/colors_res.dart';
import 'package:dentistry/user_state/user_bloc.dart';
import 'package:dentistry/widgets/custome_text_field.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CreateProfileScreen extends StatelessWidget {
  bool showPassword = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController patronymicController = TextEditingController();
  TextEditingController passportController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateProfileBloc>(
      create: (context) => CreateProfileBloc(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {},
          ),
          title: Text("Создание профиля"),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 25, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: BlocConsumer<CreateProfileBloc, CreateProfileState>(
              listener: (context, state) {
                switch (state.saveProfileState) {
                  case SaveProfile.success:
                    context.read<UserBloc>().add(OverwritingUserInfo());
                    break;
                }
              },
              builder: (context, state) {
                return ListView(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<CreateProfileBloc>()
                                  .add(const AddAvatarEvent());
                            },
                            child: Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 4,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: Offset(0, 10))
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: state.avatarImage == null
                                          ? NetworkImage(
                                              "https://firebasestorage.googleapis.com/v0/b/dl-flutter-ui-challenges.appspot.com/o/img%2F1.jpg?alt=media",
                                            )
                                          : FileImage(state.avatarImage!)
                                              as ImageProvider)),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  color: Colors.green,
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
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
                                dateController.text = DateFormat('yyyy-MM-dd').format(picked!);
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
                                borderRadius: BorderRadius.circular(12.0)),
                            color: ColorsRes.fromHex(ColorsRes.primaryColor),
                            textColor: Colors.white,
                            child: Text("Сохранить",
                                style: const TextStyle(fontSize: 16)),
                            onPressed: () {
                              context.read<CreateProfileBloc>().add(
                                  SaveInfoEvent(name: nameController.text, lastName: lastNameController.text, patronymic: patronymicController.text, passport: passportController.text, dateOfBirth: dateController.text,
                                      user: context.read<UserBloc>().state.userUID));
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: TextField(
          // controller: emailController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            focusColor: ColorsRes.fromHex(ColorsRes.primaryColor),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            hintText: labelText,
          ),
        ));
  }
}
