import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../helpers/constants.dart';
import '../../../helpers/enums.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? prefixedIcon;
  final String hintText;
  final String invalidText;
  late ValueNotifier<ValidationState> textFieldValidation;

  MyTextField({
    Key? key,
    this.controller,
    this.prefixedIcon,
    required this.hintText,
    required this.invalidText,
    required this.textFieldValidation
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: TextField(
        controller: controller,
        cursorColor: Colors.white,
        cursorWidth: 2,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: textFieldValidation.value != ValidationState.valid
              ? const UnderlineInputBorder(
                  borderSide: BorderSide(color: redColor, width: 1),
                )
              : InputBorder.none,
          filled: true,
          fillColor: fieldColor.withOpacity(0.9),
          prefixIcon: prefixedIcon,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.bold,
            fontFamily: 'PTSans',
          ),
          errorText: validationMessage(textFieldValidation.value),
          errorStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: redColor,
          ),
        ),
      ),
    );
  }

  String? validationMessage(ValidationState textFieldEmpty) {
    if (textFieldEmpty == ValidationState.empty) {
      return 'Это поле не может быть пустым';
    }
    if (textFieldEmpty == ValidationState.invalid) {
      return invalidText;
    }
    return null;
  }
}
