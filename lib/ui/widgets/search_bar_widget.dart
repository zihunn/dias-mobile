import 'package:DiAs/ui/styles/app_colors.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final String hintText;
  final Function(String)? onSubmitted;
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? hintTextColor;

  const SearchBarWidget({
    super.key,
    this.hintText = "Search...",
    this.onSubmitted,
    this.icon = Icons.search,
    this.backgroundColor,
    this.iconColor,
    this.hintTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 12.0,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.primaryColor.withOpacity(0.1),
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: iconColor ?? Colors.grey[500],
            ),
          ),
          Expanded(
            child: TextFormField(
              initialValue: null,
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
            ),
          ),
        ],
      ),
    );
  }
}
