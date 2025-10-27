// Model for badges
import 'package:flutter/material.dart';

class IconBadgeModel {
  final IconData icon;
  final int? count;
  final Color color;

  IconBadgeModel({required this.icon, this.count, required this.color});
}
