import 'package:DiAs/ui/styles/app_colors.dart';
import 'package:flutter/material.dart';

class SubcriptionsScreen extends StatefulWidget {
  const SubcriptionsScreen({super.key});

  @override
  State<SubcriptionsScreen> createState() => _SubcriptionsScreenState();
}

class _SubcriptionsScreenState extends State<SubcriptionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: const [],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              height: 100.0,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    Colors.white,
                    AppColors.secondaryColor,
                    AppColors.secondaryColor,
                  ],
                  stops: [0.1, 0.2, 0.1, 0.2, 0.5, 2.2, 2.2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x19000000),
                    blurRadius: 24,
                    offset: Offset(0, 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
