import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const MyIconButton({
    Key? key,
    required this.icon,
    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        size: 28,
        color: Colors.white,
      ),
      onPressed: onPressed,
    );
  }
}
