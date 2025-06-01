import 'package:DiAs/models/cardsearch_item_model.dart';
import 'package:DiAs/models/grid_item_model.dart';
import 'package:DiAs/models/profile_item_model.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../ui/screens/sdki/sdki_screen.dart';
import '../ui/screens/siki/siki_screen.dart';
import '../ui/screens/slki/slki_screen.dart';
import '../ui/styles/app_colors.dart';

// final List<GridItem> gridItems = [
//   GridItem(
//     title: 'SDKI',
//     color: AppColors.primaryColor.withOpacity(0.5),
//     subtitle: 'Standart Diagnosis Keperawatan Indonesia',
//     imagePath: 'assets/images/image1.png',
//     onTap: (context) {
//       Navigator.push(
//         context,
//         PageTransition(
//           child: const SdkiScreen(title: 'SDKI', isPremium: false),
//           type: PageTransitionType.rightToLeft,
//         ),
//       );
//     },
//   ),
//   GridItem(
//     title: 'SLKI',
//     color: AppColors.secondaryColor.withOpacity(0.5),
//     subtitle: 'Standart Luaran keperawatan Indonesia',
//     imagePath: 'assets/images/image2.png',
//     onTap: (context) {
//       Navigator.push(
//         context,
//         PageTransition(
//           child: const SlkiScreen(title: 'SLKI', isPremium: false),
//           type: PageTransitionType.rightToLeft,
//         ),
//       );
//     },
//   ),
//   GridItem(
//     title: 'SIKI',
//     color: Colors.green.withOpacity(0.5),
//     subtitle: 'Standart Intervensi Keperawatan Indonesia',
//     imagePath: 'assets/images/image3.png',
//     onTap: (context) {
//       Navigator.push(
//         context,
//         PageTransition(
//           child: const SikiScreen(title: 'SIKI', isPremium: false),
//           type: PageTransitionType.rightToLeft,
//         ),
//       );
//     },
//   ),
//   GridItem(
//     title: 'SDKI - SLKI - SIKI',
//     color: Colors.cyan.withOpacity(0.5),
//     subtitle: 'Standart Diagnosis Keperawatan Indonesia',
//     imagePath: 'assets/images/image4.png',
//     onTap: (context) {
//       Navigator.push(
//         context,
//         PageTransition(
//           child:
//               const SdkiScreen(title: 'SDKI - SLKI - SIKI', isPremium: false),
//           type: PageTransitionType.rightToLeft,
//         ),
//       );
//     },
//   ),
//   GridItem(
//     title: 'SPO',
//     color: Colors.amber.withOpacity(0.5),
//     subtitle: 'Standart Prosedur Operasional',
//     imagePath: 'assets/images/image5.png',
//     onTap: (context) {
//       // Navigator.push(
//       //   context,
//       //   PageTransition(
//       //     child: const SpoScreen(title: 'SPO', isPremium: false),
//       //     type: PageTransitionType.rightToLeft,
//       //   ),
//       // );
//     },
//   ),
// ];

final List<CardSearchItem> CardItem = [
  CardSearchItem(
    color: AppColors.primaryColor,
    title: 'Bersihan Jalan Napas Tidak Efektif ',
    subtitle:
        'Ketidakmampuan membersihkan sekret atau obstruksi jalan napas untuk mempertahankan jalan napas tetap paten',
    code: 'D.0001',
    category: 'Fisiologis - Respirasi',
  ),
  CardSearchItem(
    color: Colors.amber,
    title: 'Gangguan Penyapihan Ventilator',
    subtitle:
        'Ketidakmampuan beradaptasi dengan pengurangan bantuan ventilator mekanik yang dapat menghambat dan memperlama proses penyapihan.',
    code: 'D.0002',
    category: 'Fisiologis - Respiras',
  ),
  CardSearchItem(
    color: Colors.green,
    title: 'Gangguan Pertukaran Gas',
    subtitle:
        'Kelebihan atau kekurangan oksigenasi dan/atau eliminasi karbon dioksida pada membran alveolus-kapiler.',
    code: 'D.0003',
    category: 'Fisiologi - Respirasi',
  ),
  CardSearchItem(
    color: Colors.purple,
    title: 'Gangguan Ventilasi Spontan',
    subtitle:
        'Penurunan cadangan energi yang mengakibatkan individu tidak mampu bernafas secara adekuat.',
    code: 'D.0004',
    category: 'Fisiologis - Respirasi',
  ),
  CardSearchItem(
    color: Colors.redAccent,
    title: 'Pola Napas Tidak Efektif',
    subtitle:
        'Inspirasi dan/atau ekspirasi yang tidak memberikan ventilasi adekuat',
    code: 'D.0005',
    category: 'Fisiologis - Respirasi',
  ),
];

final List<ProfileItem> ProfilItem = [
  ProfileItem(
    title: "Edit Profil",
    subtitle: "Update informasi penting Anda",
    bgColor: Colors.amber.withOpacity(0.3),
    iconColor: Colors.amber,
    icon: Icons.person_outline_sharp,
    onTap: () {
      print('Edit Profile');
    },
  ),
  ProfileItem(
    title: "History Transaksi",
    subtitle: "Lihat semua transaksi yang pernah Anda lakukan di sini.",
    bgColor: Colors.green.withOpacity(0.3),
    iconColor: Colors.green,
    icon: Icons.receipt_long_outlined,
    onTap: () {
      print('History Transactions');
    },
  ),
  ProfileItem(
    title: "Ganti Password",
    subtitle: "Perbarui kata sandi untuk melindungi akses ke akun Anda.",
    bgColor: Colors.purple.withOpacity(0.3),
    iconColor: Colors.purple,
    icon: Icons.lock_open_outlined,
    onTap: () {},
  ),
  ProfileItem(
    title: "Logout",
    subtitle: "Keluar dari akun Anda",
    bgColor: Colors.red.withOpacity(0.3),
    iconColor: Colors.red,
    icon: Icons.login_rounded,
    onTap: () {},
  ),
];
