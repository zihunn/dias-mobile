import 'package:flutter/material.dart';
import 'app_colors.dart'; // Pastikan path sesuai untuk warna

class AppTextStyles {
  // Heading 1 (besar)
  static const TextStyle heading1 = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
    letterSpacing: 1.2,
    height: 1.5,
  );

  // Heading 2 (sedang)
  static const TextStyle heading2 = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
    letterSpacing: 1.1,
    height: 1.4,
  );

  // Subheading
  static const TextStyle subheading = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondaryColor,
    letterSpacing: 1.0,
    height: 1.3,
  );

  // Body text (ukuran normal)
  static const TextStyle bodyText = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textColor,
    letterSpacing: 0.5,
    height: 1.5,
  );

  // Body text untuk teks sekunder (dengan warna yang lebih redup)
  static const TextStyle bodyTextSecondary = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondaryColor,
    letterSpacing: 0.5,
    height: 1.5,
  );

  // Caption (teks kecil)
  static const TextStyle caption = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondaryColor,
    letterSpacing: 0.4,
    height: 1.3,
  );

  // Button text
  static const TextStyle buttonText = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: AppColors
        .backgroundColor, // Biasanya warna teks di tombol putih atau terang
    letterSpacing: 1.0,
    height: 1.4,
  );
}
