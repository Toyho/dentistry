import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomeTextField extends StatefulWidget {
  String? hint = "";
  TextEditingController? textController;
  List<TextInputFormatter>? inputFormatters;
  bool? obscureText = false;

  CustomeTextField({
    String? hint,
    TextEditingController? textController,
    List<TextInputFormatter>? inputFormatters,
    bool? obscureText,
  })  : this.hint = hint,
        this.inputFormatters = inputFormatters,
        this.textController = textController,
        this.obscureText = obscureText,
        super();

  @override
  _CustomeTextFieldState createState() => _CustomeTextFieldState();
}

class _CustomeTextFieldState extends State<CustomeTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: widget.obscureText ?? false,
      controller: widget.textController,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        filled: true,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
        hintText: widget.hint,
      ),
    );
  }
}
