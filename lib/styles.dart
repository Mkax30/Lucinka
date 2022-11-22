import 'package:flutter/material.dart';

ButtonStyle getButtonStyle({Color backgroundColor = Colors.grey, Color textColor = Colors.black}) => ElevatedButton.styleFrom(
  shape: const CircleBorder(),
  padding: const EdgeInsets.all(24)//,
  // backgroundColor: backgroundColor,
  // foregroundColor: textColor,
);