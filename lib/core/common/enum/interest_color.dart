
import 'package:flutter/material.dart';

enum InterestColor {
  red,
  green,
  blue,
  yellow;

  static InterestColor fromString(String color) {
    color = color.toLowerCase();
    switch (color) {
      case 'red':
        return InterestColor.red;
      case 'green':
        return InterestColor.green;
      case 'blue':
        return InterestColor.blue;
      case 'yellow':
        return InterestColor.yellow;
      default:
        return InterestColor.red;
        throw Exception('Invalid color: $color');
    }
  }

  Color get deepColor {
    switch (this) {
      case InterestColor.red:
        return Colors.red;
      case InterestColor.green:
        return Colors.green;
      case InterestColor.blue:
        return Colors.blue;
      case InterestColor.yellow:
        return Colors.yellow;
    }
  }

  Color get softColor {
    switch (this) {
      case InterestColor.red:
        return const Color.fromARGB(56, 244, 67, 54);
      case InterestColor.green:
        return const Color.fromARGB(52, 76, 175, 79);
      case InterestColor.blue:
        return const Color.fromARGB(138, 187, 222, 251);
      case InterestColor.yellow:
        return const Color.fromARGB(79, 255, 249, 196);
    }
  }
}