import 'package:DiAs/ui/screens/sdki/detail_sdki_screen.dart';
import 'package:flutter/material.dart';

import '../styles/app_text_style.dart';

class CardSearch extends StatelessWidget {
  final Color color;
  final String title;
  final String subtitle;
  final String code;
  final String category;

  const CardSearch({
    super.key,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.code,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: screenHeight * 0.001),
      padding: EdgeInsets.all(screenWidth * 0.02),
      height: screenHeight * 0.15,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: double.infinity,
            width: screenWidth * 0.02,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(
                Radius.circular(4.0),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyText.copyWith(
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  subtitle,
                  style: AppTextStyles.caption,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const Spacer(),
                Text(
                  "$code | $category",
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const DetailScreen(),
              //   ),
              // );
            },
            child: Container(
              height: screenHeight * 0.04,
              width: screenHeight * 0.04,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
