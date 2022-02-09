import 'dart:core';
import 'package:flutter/material.dart';

class InputTextfield extends StatefulWidget {
  @required
  final String labelText;
  @required
  final String placeholder;
  // final Function? validator;
  // final Function? onSaved;
  final Function? onVisiblePassword;
  @required
  final bool? isText;
  @required
  final bool? isEmail;
  @required
  final bool? isNumber;
  @required
  final bool? isRequired;
  final bool? showPassword;
  //final int? minlength;
  final dynamic icon;
  @required
  final bool? isPassword;
  @required
  final TextEditingController? controller;
  @required
  final TextInputType? type;
  const InputTextfield({
    Key? key,
    // this.minlength,
    this.showPassword,
    required this.placeholder,
    //this.validator,
    this.isEmail,
    this.isNumber,
    this.isRequired,
    this.isText,
    // this.onSaved,
    this.onVisiblePassword,
    required this.labelText,
    required this.icon,
    required this.controller,
    required this.type,
    required this.isPassword,
  }) : super(key: key);

  @override
  _InputTextfieldState createState() => _InputTextfieldState();
}

class _InputTextfieldState extends State<InputTextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 60,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        decoration: InputDecoration(
          suffixIcon: (widget.isPassword!)
              ? GestureDetector(
                  onTap: () => widget.onVisiblePassword,
                  child: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : Icon(
                  Icons.remove_red_eye,
                  color: Colors.white10,
                ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icons.edit == null
              ? null
              : Icon(
                  Icons.edit,
                  color: Colors.grey,
                  size: 24,
                ),
          // labelText: labelText,
          hintText: widget.labelText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        onSaved: (String? value) {
          value = value;
        },
        controller: widget.controller,
        obscureText:
            (widget.isPassword != false) ? widget.showPassword! : false,
        keyboardType: widget.type,
      ),
    );
  }
}
