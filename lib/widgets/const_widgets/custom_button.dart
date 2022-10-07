import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPress;
  final String buttonName;
  final Color? textColor;
  final Color? buttonColor;
  final double? elevation;
  const CustomButton({
    Key? key,
    required this.onPress,
    required this.buttonName,
    this.textColor,
    this.buttonColor,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(50.0),
        primary: buttonColor,
        elevation: elevation,
      ),
      child: Text(
        buttonName,
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'Cerebri Sans Regular',
          fontWeight: FontWeight.normal,
          color: textColor,
          letterSpacing: 1
        ),
      ).tr(),
    );
  }
}
