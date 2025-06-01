import 'package:flutter/material.dart';
import '../styles/app_text_style.dart';

class CardFitur extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final Color color;
  final Function onTap; // Fungsi onTap yang bisa dipassing

  const CardFitur({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.color,
    required this.onTap, // Menambahkan parameter onTap
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: () => onTap(), // Menjalankan onTap yang diteruskan
          child: Container(
            padding: const EdgeInsets.only(top: 8),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 24,
                  offset: Offset(0, 11),
                ),
              ],
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(24.0),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      clipBehavior: Clip.none,
                      height: MediaQuery.of(context).size.height * 0.11,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(18.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(),
                        child: Column(
                          children: [
                            Text(
                              title,
                              style: AppTextStyles.bodyText
                                  .copyWith(fontSize: screenWidth * 0.040),
                            ),
                            const SizedBox(
                              height: 2.0,
                            ),
                            Text(
                              subtitle,
                              style: AppTextStyles.caption.copyWith(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: -15,
          left: 11,
          child: Container(
            clipBehavior: Clip.none,
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(18.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
