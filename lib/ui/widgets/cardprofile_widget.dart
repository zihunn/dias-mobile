import 'package:flutter/material.dart';

import '../styles/app_text_style.dart';

class CardProfileWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color bgColor;
  final Color iconColor;
  final IconData icon;
  final Function onTap;

  const CardProfileWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.bgColor,
    required this.iconColor,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: EdgeInsets.only(bottom: screenWidth * 0.05),
        padding: EdgeInsets.all(screenWidth * 0.03),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: screenWidth * 0.13,
              width: screenWidth * 0.13,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: screenWidth * 0.07,
                color: iconColor,
              ),
            ),
            SizedBox(width: screenWidth * 0.05),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyText.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: screenWidth * 0.01),
                SizedBox(
                  width: screenWidth * 0.5,
                  child: Text(
                    subtitle,
                    style: AppTextStyles.caption.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: screenWidth * 0.06,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
