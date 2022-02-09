import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final dynamic icon;
  final bool isPassword;
  final Function? onSaved;
  final bool showPassword;
  final Function? onVisiblePassword;
  final TextEditingController controller;
  final TextInputType type;
  const CustomTextField({
    Key? key,
    required this.label,
    this.icon,
    this.onVisiblePassword,
    this.onSaved,
    required this.showPassword,
    required this.controller,
    required this.type,
    required this.isPassword,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    //bool showPassword = false;
    return Container(
      width: MediaQuery.of(context).size.width - 60,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        obscureText: widget.isPassword ? widget.showPassword : false,
        controller: widget.controller,
        decoration: InputDecoration(
          suffixIcon: widget.isPassword
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
          prefixIcon: widget.icon == null
              ? null
              : Icon(
                  widget.icon,
                  color: Colors.grey,
                  size: 25,
                ),
          hintText: widget.label,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        onSaved: (String? value) {
          value = value;
        },
        keyboardType: widget.type,
      ),
    );
  }
}
