import 'package:flutter/material.dart';

class GridItem {
  final String title;
  final Color color;
  final String subtitle;
  final String imagePath;
  final Function onTap; // Menambahkan variabel onTap

  GridItem({
    required this.title,
    required this.color,
    required this.subtitle,
    required this.imagePath,
    required this.onTap, // Menambahkan parameter onTap pada konstruktor
  });
}
