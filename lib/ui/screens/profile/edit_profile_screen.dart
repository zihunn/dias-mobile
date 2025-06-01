import 'dart:io';
import 'package:DiAs/ui/widgets/bottomsheets_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../bloc/login/login_bloc.dart';
import '../../../bloc/login/login_event.dart';
import '../../../bloc/login/login_state.dart';
import '../../styles/app_text_style.dart';
import '../../widgets/loading_button_widget.dart';
import '../../widgets/textfield_widget.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  const EditProfileScreen({
    super.key,
    required this.user,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  DateTime? _selectedDate;
  String? _selectedGender;
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Set initial name from user data
    nameController.text = '';
    _selectedGender = null;
    _selectedDate = null;
    String dateUser = widget.user['birth_date'] != null
        ? _formatDate(DateTime.parse(widget.user['birth_date']))
        : 'Tanggal tidak tersedia'; // Nilai default jika null
  }

  // Future<void> _pickImage() async {
  //   var storageStatus = await Permission.photos.request();

  //   if (storageStatus.isGranted) {
  //     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //     if (pickedFile != null) {
  //       setState(() {
  //         _selectedImage = File(pickedFile.path);
  //       });
  //     }
  //   } else {
  //     print("Permission denied");
  //   }
  // }
  Future<void> _pickImage() async {
    // Meminta izin akses foto
    var storageStatus = await Permission.storage.request();

    if (storageStatus.isGranted) {
      // Jika izin diberikan, buka galeri
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } else if (storageStatus.isDenied) {
      // Jika izin ditolak
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Permission to access photos is denied")),
      );
      openAppSettings();
    } else if (storageStatus.isPermanentlyDenied) {
      // Jika izin ditolak secara permanen, buka pengaturan aplikasi
      openAppSettings();
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  String _formatDate(DateTime? date) {
    print('format date');
    print(date);
    if (date == null) return '-';
    return '${date.year}-${date.month}-${date.day}';
  }

  void _updateProfile() {
    final updatedName = nameController.text.isNotEmpty
        ? nameController.text
        : widget.user['name'] ?? '';
    final updatedGender = _selectedGender ?? widget.user['gender'] ?? '';
    final updatedBirthDate = _selectedDate?.toIso8601String();

    if (nameController.text.isEmpty &&
        _selectedGender == null &&
        _selectedDate == null) {
      print('Tidak ada perubahan');
      return;
    }

    setState(() {
      isLoading = true;
    });

    final event = UpdateProfileEvent(
      name: updatedName,
      gender: updatedGender,
      birthDate: updatedBirthDate,
      profileImage: _selectedImage,
    );

    context.read<AuthBloc>().add(event);
  }

  var dateUser = '';

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var user = widget.user;
    print(user);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          setState(
            () {
              isLoading = true;
            },
          );
        }
        if (state is UpdateProfileSuccess) {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profil berhasil diperbarui")),
          );
          Navigator.pop(context); // Kembali ke layar sebelumnya
        } else if (state is UpdateProfileFailure) {
          setState(() {
            isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profil gagal diperbarui")),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Text("Edit Profile"),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: ClipOval(
                    child: Container(
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: _selectedImage != null
                              ? FileImage(_selectedImage!)
                              : (user['image'] != null
                                      ? NetworkImage(user['image'])
                                      : const AssetImage(
                                          'assets/images/no-image.png'))
                                  as ImageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        children: [
                          const Spacer(),
                          Container(
                            height: 50,
                            width: screenWidth,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.6),
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 40.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Text(
                "Nama Lengkap :",
                style: AppTextStyles.caption.copyWith(fontSize: 17),
              ),
              const SizedBox(height: 5.0),
              TextFieldWidget.standardTextField(
                controller: nameController,
                hintText: user['name'] ?? "Nama Lengkap",
              ),
              const SizedBox(height: 20.0),
              Text(
                "Email :",
                style: AppTextStyles.caption.copyWith(fontSize: 17),
              ),
              const SizedBox(height: 5.0),
              TextFieldWidget.standardTextField(
                hintText: user['email'],
                enabled: false,
              ),
              const SizedBox(height: 20.0),
              Text(
                "Jenis Kelamin :",
                style: AppTextStyles.caption.copyWith(fontSize: 17),
              ),
              const SizedBox(height: 5.0),
              GestureDetector(
                onTap: () {
                  BottomsheetsWidget.showGenderSelection(
                    gender: _selectedGender ?? user['gender'] ?? Null,
                    context: context,
                    onGenderSelected: (gender) {
                      setState(() {
                        _selectedGender = gender;
                      });
                    },
                  );
                },
                child: TextFieldWidget.standardTextField(
                  hintText: _selectedGender ?? user['gender'] ?? '-',
                  enabled: false,
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                "Tanggal Lahir :",
                style: AppTextStyles.caption.copyWith(fontSize: 17),
              ),
              const SizedBox(height: 5.0),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: TextFieldWidget.standardTextField(
                  hintText: _selectedDate?.toIso8601String().split('T').first ??
                      dateUser ??
                      '',
                  enabled: false,
                ),
              ),
              const SizedBox(height: 50.0),
              LoadingButtonWidget(
                isLoading: isLoading,
                buttonText: "Simpan",
                onPressed: _updateProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
