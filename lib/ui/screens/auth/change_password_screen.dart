// import 'package:flutter/material.dart';
// import 'package:DiAs/ui/styles/app_text_style.dart';
// import 'package:DiAs/ui/widgets/textfield_widget.dart';
// import 'package:DiAs/ui/widgets/loading_button_widget.dart';

// import 'otp_reset_password_screen.dart';
// import 'otp_screen.dart';

// class ChangePasswordScreen extends StatefulWidget {
//   const ChangePasswordScreen({super.key});

//   @override
//   State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
// }

// class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
//   bool isLoading = false;
//   final TextEditingController passwordCtrl = TextEditingController();
//   final TextEditingController emailCtrl = TextEditingController();
//   String? emailError; // Menyimpan pesan error untuk validasi email

//   // Fungsi untuk validasi email
//   bool isValidEmail(String email) {
//     final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
//     return emailRegex.hasMatch(email);
//   }

//   Future<void> handleButtonPress() async {
//     // Lakukan validasi sebelum menampilkan loading
//     if (emailCtrl.text.isEmpty) {
//       setState(() {
//         emailError = "Email tidak boleh kosong";
//       });
//       return;
//     } else if (!isValidEmail(emailCtrl.text)) {
//       setState(() {
//         emailError = "Format email tidak valid";
//       });
//       return;
//     }

//     // Jika validasi lolos, reset error dan mulai loading
//     setState(() {
//       emailError = null;
//       isLoading = true;
//     });

//     // Simulasi pemanggilan API atau proses lainnya
//     await Future.delayed(const Duration(seconds: 2));

//     setState(() {
//       isLoading = false;
//     });

//     // Pindah ke halaman OTP
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => OtpResetPasswordScreen(

//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: const Text("Ubah Password"),
//         centerTitle: true,
//       ),
//       body: Container(
//         padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
//         child: Column(
//           children: [
//             Container(
//               height: screenHeight * 0.3,
//               width: screenWidth,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/image6.png'),
//                 ),
//               ),
//             ),
//             const Text(
//               "Masukkan email dan password baru Anda, kami akan mengirimkan kode verifikasi.",
//               style: AppTextStyles.caption,
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 15.0),
//             TextFieldWidget.standardTextField(
//               controller: emailCtrl,
//               icon: Icons.email_rounded,
//               hintText: 'Masukan Email',
//               errorText: emailError, // Menampilkan pesan error jika ada
//               onChanged: (value) {
//                 // Reset error ketika pengguna mengetik ulang email
//                 if (emailError != null) {
//                   setState(() {
//                     emailError = null;
//                   });
//                 }
//               },
//             ),
//             const SizedBox(
//               height: 15.0,
//             ),
//             TextFieldWidget.standardTextField(
//                 hintText: "Masukan password",
//                 isPassword: true,
//                 controller: passwordCtrl),
//             const Spacer(),
//             LoadingButtonWidget(
//               isLoading: isLoading,
//               buttonText: "Dapatkan Kode",
//               onPressed: handleButtonPress,
//               textColor: Colors.white,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:DiAs/services/api_service.dart';
import 'package:DiAs/ui/styles/app_text_style.dart';
import 'package:DiAs/ui/widgets/loading_button_widget.dart';
import 'package:DiAs/ui/widgets/textfield_widget.dart';

import 'otp_reset_password_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool isLoading = false;
  final TextEditingController emailCtrl = TextEditingController();
  String? emailError; // Menyimpan pesan error untuk validasi email

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> sendOtp() async {
    if (emailCtrl.text.isEmpty) {
      setState(() {
        emailError = "Email tidak boleh kosong";
      });
      return;
    } else if (!isValidEmail(emailCtrl.text)) {
      setState(() {
        emailError = "Format email tidak valid";
      });
      return;
    }

    setState(() {
      emailError = null;
      isLoading = true;
    });

    final apiService = ApiService();
    final response = await apiService.sendPasswordResetOtp(emailCtrl.text);

    setState(() {
      isLoading = false;
    });

    if (response['status']) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpResetPasswordScreen(
            email: emailCtrl.text,
            password: '',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Ubah Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.3,
              width: screenWidth,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/image6.png'),
                ),
              ),
            ),
            const Text(
              "Masukkan email dan password baru Anda, kami akan mengirimkan kode verifikasi.",
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15.0),
            TextFieldWidget.standardTextField(
              controller: emailCtrl,
              icon: Icons.email_rounded,
              hintText: 'Masukan Email',
              errorText: emailError,
            ),
            const SizedBox(height: 15.0),
            LoadingButtonWidget(
              isLoading: isLoading,
              buttonText: "Dapatkan Kode",
              onPressed: sendOtp,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
