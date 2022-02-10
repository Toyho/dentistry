import 'package:dentistry/profile/create_profile/create_profile_bloc.dart';
import 'package:dentistry/resources/colors_res.dart';
import 'package:dentistry/user_state/user_bloc.dart';
import 'package:dentistry/widgets/custome_text_field.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateProfileScreen extends StatefulWidget {
  CreateProfileScreen(
      {this.name, this.lastName, this.patronymic, this.passport, this.dateOfBirth, Key? key})
      : super(key: key);

  String? name;
  String? lastName;
  String? patronymic;
  String? passport;
  String? dateOfBirth;

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController patronymicController = TextEditingController();
  TextEditingController passportController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    nameController.text = widget.name ?? "";
    lastNameController.text = widget.lastName ?? "";
    patronymicController.text = widget.patronymic ?? "";
    passportController.text = widget.passport ?? "";
    dateController.text = widget.dateOfBirth ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var localText = AppLocalizations.of(context)!;
    var userState = context.read<UserBloc>().state;

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
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            userState.isAuth!
                ? localText.editingProfile
                : localText.createProfile,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
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
                    if (userState.isAuth!) {
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.pop(context);
                      });
                    } else {
                      Future(() {
                        Navigator.pushReplacementNamed(context, "/auth_screen");
                      });
                    }
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
                                              userState.isAuth!
                                                  ? userState.userAvatar!
                                                  : "https://firebasestorage.googleapis.com/v0/b/dentistry-4e364.appspot.com/o/defaultAvatar.png?alt=media&token=a26bface-9b6a-4863-acc3-85f1b9adff5b",
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
                                  color: ColorsRes.fromHex(ColorsRes.primaryColor),
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
                    Padding(
                        padding: const EdgeInsets.only(bottom: 35.0),
                        child: TextField(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(1940, 1),
                                lastDate: DateTime.now(),
                                initialEntryMode: DatePickerEntryMode.input);
                            dateController.text =
                                DateFormat('yyyy-MM-dd').format(picked!);
                          },
                          readOnly: true,
                          controller: dateController,
                          decoration: InputDecoration(
                              filled: true,
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              hintText: localText.dateOfBirth,
                              suffixIcon:
                                  const Icon(Icons.calendar_today_outlined)),
                        )),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: SizedBox(
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
                              child: Text(localText.save,
                                  style: const TextStyle(fontSize: 16)),
                              onPressed: () {
                                context.read<CreateProfileBloc>().add(
                                    SaveInfoEvent(
                                        name: nameController.text,
                                        lastName: lastNameController.text,
                                        patronymic: patronymicController.text,
                                        passport: passportController.text,
                                        dateOfBirth: dateController.text,
                                        userUID: context
                                            .read<UserBloc>()
                                            .state
                                            .userUID,
                                        userEmail: context
                                            .read<UserBloc>()
                                            .state
                                            .email,
                                        currentAvatar: userState.userAvatar));
                              },
                            ),
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
}
