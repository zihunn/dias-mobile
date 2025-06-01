import 'package:DiAs/ui/screens/payments/payment_webview_screen.dart';
import 'package:DiAs/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:DiAs/ui/styles/app_colors.dart';
import 'package:DiAs/ui/styles/app_text_style.dart';
import 'package:DiAs/ui/widgets/search_bar_widget.dart';
import 'package:DiAs/utils/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

import '../../bloc/login/login_bloc.dart';
import '../../bloc/login/login_state.dart';
import '../../bloc/payment/payment_bloc.dart';

import '../../bloc/payment/payment_state.dart';
import '../../models/grid_item_model.dart';
import '../widgets/bottomsheets_widget.dart';
import '../widgets/cardfitur_widget.dart';
import 'sdki/sdki_screen.dart';
import 'siki/siki_screen.dart';
import 'slki/slki_screen.dart';

class HomeScreen extends StatelessWidget {
  final Map<String, dynamic> userNonBloc;
  const HomeScreen({
    super.key,
    required this.userNonBloc,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    // Panggil fungsi updateUserData() untuk memastikan ValueNotifier diinisialisasi
    updateUserData();

    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, PaymentState) {
        if (PaymentState is! PaymentLoading) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        if (PaymentState is PaymentLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(
              child: SizedBox(
                height: 100,
                width: 100,
                child: Lottie.asset('assets/lotties/loading.json'),
              ),
            ),
          );
        } else if (PaymentState is PaymentSuccess) {
          Navigator.pop(context);
          final url = PaymentState.transactionResponse.redirectUrl;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentWebView(url: url),
            ),
          );
        } else if (PaymentState is PaymentFailure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(PaymentState.error)),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              // Gunakan ValueListenableBuilder untuk mendengarkan perubahan data user
              return ValueListenableBuilder(
                valueListenable: userNotifier,
                builder: (context, user, _) {
                  print('home');
                  user = user['user'] ?? user;
                  // print(user['is_premium']);

                  final List<GridItem> gridItems = [
                    GridItem(
                      title: 'SDKI',
                      color: AppColors.primaryColor.withOpacity(0.5),
                      subtitle: 'Standart Diagnosis Keperawatan Indonesia',
                      imagePath: 'assets/images/image1.png',
                      onTap: (context) {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: SdkiScreen(
                                isDetail: false,
                                title: 'SDKI',
                                isPremium: user['is_premium']),
                            type: PageTransitionType.rightToLeft,
                          ),
                        );
                      },
                    ),
                    GridItem(
                      title: 'SLKI',
                      color: AppColors.secondaryColor.withOpacity(0.5),
                      subtitle: 'Standart Luaran keperawatan Indonesia',
                      imagePath: 'assets/images/image2.png',
                      onTap: (context) {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: SlkiScreen(
                                title: 'SLKI', isPremium: user['is_premium']),
                            type: PageTransitionType.rightToLeft,
                          ),
                        );
                      },
                    ),
                    GridItem(
                      title: 'SIKI',
                      color: Colors.green.withOpacity(0.5),
                      subtitle: 'Standart Intervensi Keperawatan Indonesia',
                      imagePath: 'assets/images/image3.png',
                      onTap: (context) {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: SikiScreen(
                                title: 'SIKI', isPremium: user['is_premium']),
                            type: PageTransitionType.rightToLeft,
                          ),
                        );
                      },
                    ),
                    GridItem(
                      title: 'SDKI - SLKI - SIKI',
                      color: Colors.cyan.withOpacity(0.5),
                      subtitle: 'Standart Diagnosis Keperawatan Indonesia',
                      imagePath: 'assets/images/image4.png',
                      onTap: (context) {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: SdkiScreen(
                                isDetail: true,
                                title: 'SDKI - SLKI - SIKI',
                                isPremium: user['is_premium']),
                            type: PageTransitionType.rightToLeft,
                          ),
                        );
                      },
                    ),
                    GridItem(
                      title: 'SPO',
                      color: Colors.amber.withOpacity(0.5),
                      subtitle: 'Standart Prosedur Operasional',
                      imagePath: 'assets/images/image5.png',
                      onTap: (context) {
                        // Navigator.push(
                        //   context,
                        //   PageTransition(
                        //     child: const SpoScreen(title: 'SPO', isPremium: false),
                        //     type: PageTransitionType.rightToLeft,
                        //   ),
                        // );
                      },
                    ),
                  ];

                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.02,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: screenWidth * 0.08,
                                backgroundImage: user['image'] != null
                                    ? NetworkImage(user['image'])
                                    : const AssetImage(
                                            'assets/images/no-image.png')
                                        as ImageProvider,
                              ),
                              SizedBox(width: screenWidth * 0.03),
                              Flexible(
                                flex: screenWidth > 600 ? 3 : 2,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.025),
                                  height: screenHeight * 0.1,
                                  child: Text(
                                    "Hey ${user['name']?.toString().split(' ').first ?? 'Pengguna'}, Bagaimana Kabarnya Hari ini?",
                                    style: AppTextStyles.bodyTextSecondary,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: screenWidth > 600 ? 2 : 1,
                                child: Container(),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          const SearchBarWidget(),
                          SizedBox(height: screenHeight * 0.025),
                          Stack(
                            children: [
                              Container(
                                height: screenHeight * 0.25,
                                padding:
                                    const EdgeInsets.fromLTRB(0, 12, 12, 0),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(18.0),
                                  ),
                                ),
                                child: Container(
                                  height: screenHeight * 0.2,
                                  width: screenWidth,
                                  padding: EdgeInsets.all(screenWidth * 0.03),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryColor
                                        .withOpacity(0.8),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(18.0),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: screenWidth * 0.5,
                                        child: Text(
                                          "Upgrade ke Premium dan nikmati konten tanpa batas.",
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.045,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.accentColor,
                                          foregroundColor: Colors.white,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.08,
                                            vertical: screenHeight * 0.01,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: () {
                                          print(user['is_premium']);
                                          BottomsheetsWidget
                                              .BottomsheetsPremium(
                                            context,
                                            user['is_premium'],
                                            user['id'],
                                          );
                                        },
                                        child: Text(
                                          "Premium",
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.04,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: -15,
                                child: Container(
                                  height: screenHeight * 0.19,
                                  width: screenWidth * 0.44,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/pay.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.025),
                          Text(
                            "Apa yang anda butuhkan?",
                            style: AppTextStyles.heading2.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: screenWidth * 0.05,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: screenWidth < 600 ? 2 : 3,
                              mainAxisSpacing: screenWidth * 0.05,
                              crossAxisSpacing: screenWidth * 0.05,
                              childAspectRatio: screenWidth < 600 ? 1 : 1.2,
                            ),
                            itemCount: gridItems.length,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              final item = gridItems[index];
                              return CardFitur(
                                color: item.color,
                                imagePath: item.imagePath,
                                subtitle: item.subtitle,
                                title: item.title,
                                onTap: () {
                                  item.onTap(context);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
