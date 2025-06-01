import 'package:DiAs/ui/styles/app_colors.dart';
import 'package:flutter/material.dart';

class LoadingButtonWidget extends StatelessWidget {
  final bool isLoading;
  final String buttonText;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color loadingColor;
  final double borderRadius;

  const LoadingButtonWidget({
    super.key,
    required this.isLoading,
    required this.buttonText,
    required this.onPressed,
    this.backgroundColor = AppColors.secondaryColor,
    this.textColor = Colors.white,
    this.loadingColor = Colors.white,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10),
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: isLoading ? null : onPressed, // Disable button when loading
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(loadingColor),
                  strokeWidth: 2.0,
                ),
              )
            : Text(
                buttonText,
                style: TextStyle(fontSize: 16, color: textColor),
              ),
      ),
    );
  }
}
