import 'dart:math' as math;
import 'package:DiAs/ui/screens/auth/login_screen.dart';
import 'package:DiAs/ui/screens/payments/payment_webview_screen.dart';
import 'package:DiAs/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simple_shadow/simple_shadow.dart';

import 'package:DiAs/ui/screens/auth/change_password_screen.dart';
import 'package:DiAs/ui/screens/profile/edit_profile_screen.dart';
import 'package:DiAs/ui/screens/transactions/history_transactions_screen.dart';
import 'package:DiAs/ui/styles/app_colors.dart';
import 'package:DiAs/ui/styles/app_text_style.dart';
import 'package:DiAs/utils/constants.dart';

import '../../../bloc/login/login_bloc.dart';
import '../../../bloc/login/login_event.dart';
import '../../../bloc/login/login_state.dart';
import '../../../bloc/payment/payment_bloc.dart';
import '../../../bloc/payment/payment_state.dart';
import '../../widgets/cardprofile_widget.dart';

class ProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userNonBloc;
  const ProfileScreen({
    super.key,
    required this.userNonBloc,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    String getRemainingTime(String? expirationDate) {
      if (expirationDate == null || expirationDate.isEmpty) {
        return 'Expired';
      }

      try {
        DateTime expiration = DateFormat("yyyy-MM-dd").parse(expirationDate);
        DateTime now = DateTime.now();

        Duration difference = expiration.difference(now);
        if (difference.isNegative) {
          return 'Expired';
        }

        int remainingDays = difference.inDays;
        return '$remainingDays Hari';
      } catch (e) {
        return 'Invalid Date';
      }
    }

    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) {
        if (state is PaymentLoading) {
          // Tampilkan indikator loading
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
        } else if (state is PaymentSuccess) {
          // Hapus indikator loading
          Navigator.pop(context);

          // Arahkan ke halaman Midtrans menggunakan redirectUrl
          final url = state.transactionResponse.redirectUrl;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentWebView(url: url),
            ),
          );
        } else if (state is PaymentFailure) {
          // Hapus indikator loading jika ada
          Navigator.pop(context);

          // Tampilkan pesan error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              // Default data user kosong
              Map<String, dynamic> users = widget.userNonBloc;

              // Gunakan data user dari state AuthSuccess atau UpdateProfileSuccess
              if (state is AuthSuccess || state is UpdateProfileSuccess) {
                users = state is AuthSuccess
                    ? state.userData
                    : (state as UpdateProfileSuccess).updatedUser;
              } else if (state is UpdateProfileFailure) {
                final failureMessage = state.message;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(failureMessage)),
                  );
                });

                if (context.read<AuthBloc>().state is AuthSuccess) {
                  users =
                      (context.read<AuthBloc>().state as AuthSuccess).userData;
                } else if (context.read<AuthBloc>().state
                    is UpdateProfileSuccess) {
                  users =
                      (context.read<AuthBloc>().state as UpdateProfileSuccess)
                          .updatedUser;
                }
              }

              if (state is AuthInitial) {
                // Navigate to the Login Page when the state is AuthInitial
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                });
              }

              if (users.isEmpty) {
                users = widget.userNonBloc;
              }

              return ValueListenableBuilder<Map<String, dynamic>>(
                valueListenable: userNotifier,
                builder: (context, user, _) {
                  print('profile screen');
                  print(users);
                  user = user['user'] ?? user;
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Column(
                      children: [
                        Container(
                          width: screenWidth,
                          padding: EdgeInsets.all(screenWidth * 0.03),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(38),
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(top: screenHeight * 0.02),
                                height: screenHeight * 0.1,
                                width: screenWidth * 0.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: user['image'] != null
                                        ? NetworkImage(user['image'])
                                        : const AssetImage(
                                                'assets/images/no-image.png')
                                            as ImageProvider,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.015),
                              Text(
                                user['name'] ?? '',
                                style: AppTextStyles.heading2,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                user['email'] ?? '',
                                style: AppTextStyles.caption.copyWith(
                                  fontSize: screenWidth * 0.035,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: screenHeight * 0.04),
                              user['is_premium'] == true
                                  ? Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          height: screenHeight * 0.1,
                                          width: screenWidth * 0.6,
                                          margin: EdgeInsets.only(
                                              bottom: screenHeight * 0.01),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.amber.withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                bottom: -screenHeight * 0.04,
                                                left: -screenWidth * 0.08,
                                                child: Transform.rotate(
                                                  angle: -math.pi / -7,
                                                  child: Image.asset(
                                                    "assets/images/shape.png",
                                                    height: screenHeight * 0.1,
                                                    width: screenWidth * 0.25,
                                                    opacity:
                                                        const AlwaysStoppedAnimation(
                                                            0.3),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: -screenHeight * 0.04,
                                                right: -screenWidth * 0.08,
                                                child: Transform.rotate(
                                                  angle: -math.pi / -7,
                                                  child: Image.asset(
                                                    "assets/images/shape.png",
                                                    height: screenHeight * 0.1,
                                                    width: screenWidth * 0.25,
                                                    opacity:
                                                        const AlwaysStoppedAnimation(
                                                            0.3),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: screenHeight * 0.1,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: screenWidth * 0.2,
                                                      color: Colors.transparent,
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            screenWidth * 0.02),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ShaderMask(
                                                              shaderCallback:
                                                                  (Rect
                                                                      bounds) {
                                                                return const LinearGradient(
                                                                  colors: [
                                                                    Colors
                                                                        .black,
                                                                    Colors
                                                                        .purple,
                                                                  ],
                                                                  begin: Alignment
                                                                      .bottomLeft,
                                                                  end: Alignment
                                                                      .topRight,
                                                                ).createShader(
                                                                    bounds);
                                                              },
                                                              child: Text(
                                                                "Elite Care",
                                                                style: AppTextStyles
                                                                    .subheading
                                                                    .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                            const Spacer(),
                                                            Row(
                                                              children: [
                                                                const Icon(
                                                                  Icons.timer,
                                                                  size: 20.0,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                SizedBox(
                                                                    width:
                                                                        screenWidth *
                                                                            0.01),
                                                                Text(
                                                                  getRemainingTime(
                                                                      user['premium_expiration'] ??
                                                                          '1970-01-01'),
                                                                  style: AppTextStyles
                                                                      .caption
                                                                      .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                    fontSize:
                                                                        screenWidth *
                                                                            0.04,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: -screenHeight * 0.02,
                                          left: -screenWidth * 0.01,
                                          child: SimpleShadow(
                                            opacity: 0.25,
                                            color: Colors.black,
                                            offset: const Offset(4, 3),
                                            sigma: 2,
                                            child: Image.asset(
                                              'assets/images/elit-care.png',
                                              width: screenWidth * 0.25,
                                              height: screenHeight * 0.1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox()
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        ListView.builder(
                          itemCount: ProfilItem.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            var item = ProfilItem[index];
                            return CardProfileWidget(
                              title: item.title,
                              subtitle: item.subtitle,
                              bgColor: item.bgColor,
                              iconColor: item.iconColor,
                              icon: item.icon,
                              onTap: () {
                                if (item.title == "Ganti Password") {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      child: const ChangePasswordScreen(),
                                      type: PageTransitionType.rightToLeft,
                                    ),
                                  );
                                } else if (item.title == "Edit Profil") {
                                  print('profile');
                                  print(user);
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      child: EditProfileScreen(user: user),
                                      type: PageTransitionType.rightToLeft,
                                    ),
                                  );
                                } else if (item.title == "History Transaksi") {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      child: HistoryTransactionsScreen(
                                        idUser: user['id'],
                                      ),
                                      type: PageTransitionType.rightToLeft,
                                    ),
                                  );
                                } else if (item.title == "Logout") {
                                  context.read<AuthBloc>().add(LogoutEvent());
                                }
                              },
                            );
                          },
                        ),
                      ],
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
