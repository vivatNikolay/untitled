import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../helpers/constants.dart';

class LoginButton extends StatefulWidget {
  final VoidCallback? onPressed;
  late ValueNotifier<bool> isButtonActive;

  LoginButton({
    Key? key,
    this.onPressed,
    required this.isButtonActive
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginButtonState(onPressed, isButtonActive);
}

class _LoginButtonState extends State<LoginButton> with SingleTickerProviderStateMixin {
  final VoidCallback? onPressed;
  late ValueNotifier<bool> isButtonActive;
  late double scale;
  late AnimationController controller;

  _LoginButtonState(this.onPressed, this.isButtonActive);

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scale = 1 - controller.value;
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTapDown: _tapDown,
        onTapUp: _tapUp,
        child: Transform.scale(
          scale: scale,
          child: _animatedButton(),
        ),
        onTap: onPressed,
      ),
    );
  }

  _animatedButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: buttonColor.withOpacity(0.7),
        border: const Border.fromBorderSide(
            BorderSide(color: Colors.white, width: 2)),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Center(
        child: Text(
          'Войти',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    if (isButtonActive.value) {
      controller.forward();
    }
  }
  void _tapUp(TapUpDetails details) {
    if (isButtonActive.value) {
      controller.reverse();
    }
  }
}
