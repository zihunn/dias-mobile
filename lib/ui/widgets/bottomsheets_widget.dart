import 'package:DiAs/bloc/payment/payment_bloc.dart';
import 'package:DiAs/bloc/payment/payment_event.dart';
import 'package:DiAs/ui/styles/app_colors.dart';
import 'package:DiAs/ui/styles/app_text_style.dart';
import 'package:DiAs/ui/widgets/loading_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomsheetsWidget {
  static void showGenderSelection({
    required BuildContext context,
    required String gender,
    required Function(String) onGenderSelected,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        String selectedGender = gender;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.3,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedGender = 'Laki - Laki';
                          });
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: selectedGender == 'Laki - Laki'
                                ? AppColors.secondaryColor.withOpacity(0.3)
                                : AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            border: Border.all(
                              width: 1.0,
                              color: selectedGender == 'Laki - Laki'
                                  ? AppColors.secondaryColor
                                  : AppColors.primaryColor,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/men.png",
                                width: 60.0,
                                height: 60.0,
                              ),
                              const SizedBox(height: 5.0),
                              const Text(
                                "Laki - Laki",
                                style: AppTextStyles.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedGender = 'Perempuan';
                          });
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: selectedGender == 'Perempuan'
                                ? AppColors.secondaryColor.withOpacity(0.3)
                                : AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            border: Border.all(
                              width: 1.0,
                              color: selectedGender == 'Perempuan'
                                  ? AppColors.secondaryColor
                                  : AppColors.primaryColor,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/women.png",
                                width: 60.0,
                                height: 60.0,
                              ),
                              const SizedBox(height: 5.0),
                              const Text(
                                "Perempuan",
                                style: AppTextStyles.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  LoadingButtonWidget(
                    isLoading: false,
                    buttonText: 'Simpan',
                    onPressed: () {
                      onGenderSelected(selectedGender);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // ignore: non_constant_identifier_names
  static void BottomsheetsPremium(
      BuildContext context, bool isPremium, int userId) async {
    var screenWidth = MediaQuery.of(context).size.width;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true, // Allows the bottom sheet to take more space
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          // height: screenHeight * 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(12, 18, 12, 12),
                width: screenWidth,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SimpleShadow(
                          opacity: 0.25,
                          color: Colors.black,
                          offset: const Offset(4, 3),
                          sigma: 2,
                          child: const Image(
                            width: 50.0,
                            height: 50.0,
                            image: AssetImage("assets/images/DiAs Logo.png"),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                              color: Colors.white,
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
                            child: const Icon(
                              Icons.close_rounded,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: screenWidth * 0.8,
                      child: Text(
                        "Akses Fitur Lengkap Sekarang",
                        style: AppTextStyles.heading2.copyWith(
                            fontSize: 31, color: AppColors.secondaryColor),
                      ),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    Text(
                      "- Akses Semua Fitur Eksklusif SDKI, SIKI, dan SLKI",
                      style: AppTextStyles.caption.copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "- Pencarian Tanpa Batas, Jelajahi Sebebas Mungkin!",
                      style: AppTextStyles.caption.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                // height: screenHeight * 0.050,
                width: screenWidth,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Monthly Plans",
                          style: AppTextStyles.caption,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(3.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "60% OFF",
                              style: AppTextStyles.caption.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Text(
                          "Rp. 50,000",
                          style: AppTextStyles.caption.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        const Icon(
                          Icons.arrow_forward_rounded,
                          size: 20.0,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Rp. 30,000",
                          style: AppTextStyles.caption.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColors.textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // const Spacer(),
              Container(
                margin: const EdgeInsets.all(10),
                child: LoadingButtonWidget(
                  isLoading: false,
                  buttonText: isPremium == false
                      ? 'Langanan'
                      : 'Anda Sudah Berlanganan',
                  onPressed: () {
                    print(token);
                    isPremium == false
                        ? context
                            .read<PaymentBloc>()
                            .add(CreateTransactionEvent(
                              userId: userId,
                              amount: 30000,
                              // amount: 1000,
                              token: token!,
                            ))
                        : null;
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

/*
8081 -> si5f0
8082 -> adak
8083 -> kosong
8084 -> sibeda
8085 -> kosong
8086 -> ta
8087 -> kosong
8088 -> kep
54333 -> PostgreSQL database (feeder)
3003 -> pddikti
8100 -> feeder
 */