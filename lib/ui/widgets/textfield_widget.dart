import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/app_colors.dart';
import '../styles/app_text_style.dart';

class TextFieldWidget {
  static Widget standardTextField({
    String? hintText,
    Function(String)? onSubmitted,
    Function(String)? onChanged,
    IconData? icon,
    Color? backgroundColor,
    bool? enabled,
    Color? iconColor,
    Color? hintTextColor,
    TextEditingController? controller,
    bool isPassword = false,
    String? errorText, // Parameter untuk pesan error
  }) {
    bool obscureText = isPassword;

    return StatefulBuilder(builder: (context, setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.primaryColor.withOpacity(0.2),
              borderRadius: const BorderRadius.all(
                Radius.circular(15.0),
              ),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      icon,
                      color: iconColor ?? Colors.grey[500],
                    ),
                  ),
                Expanded(
                  child: TextFormField(
                    enabled: enabled ?? true,
                    controller: controller,
                    obscureText: obscureText,
                    decoration: InputDecoration.collapsed(
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: hintText,
                      hintStyle: TextStyle(
                        color: hintTextColor ?? Colors.grey[500],
                      ),
                      hoverColor: Colors.transparent,
                    ),
                    onFieldSubmitted: onSubmitted,
                    onChanged: onChanged,
                  ),
                ),
                if (isPassword)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    child: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey[500],
                    ),
                  ),
              ],
            ),
          ),
          if (errorText != null) // Tampilkan pesan error jika ada
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 12.0),
              child: Text(
                errorText,
                style: TextStyle(color: Colors.red, fontSize: 12.0),
              ),
            ),
        ],
      );
    });
  }

  static Widget OtpWidget({
    BuildContext? context,
    TextEditingController? controller,
  }) {
    return Container(
      height: 60,
      width: 60,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.2),
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context!).nextFocus();
          }
        },
        style: AppTextStyles.heading1,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
