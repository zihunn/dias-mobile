// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ProfileItem {
  final String title;
  final String subtitle;
  final Color bgColor;
  final Color iconColor;
  final IconData icon;
  final Function onTap;
  ProfileItem({
    required this.title,
    required this.subtitle,
    required this.bgColor,
    required this.iconColor,
    required this.icon,
    required this.onTap,
  });
}
