// Model for badges
import 'package:flutter/material.dart';

class BadgeModel {
  final IconData icon;
  final int? count; // nullable
  final Color color;

  BadgeModel({required this.icon, this.count, required this.color});
}