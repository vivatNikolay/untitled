import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../helpers/constants.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const LoginButton({
    Key? key,
    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: buttonColor.withOpacity(0.7),
          side: const BorderSide(color: Colors.white, width: 2),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
        child: const Text(
          'Войти',
          style: TextStyle(
            fontFamily: 'PT-Sans',
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
