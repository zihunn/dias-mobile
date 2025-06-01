import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Inisialisasi ValueNotifier
ValueNotifier<Map<String, dynamic>> userNotifier =
    ValueNotifier<Map<String, dynamic>>({});

Future<void> updateUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userDataString = prefs.getString('user');

  if (userDataString != null) {
    // Parsing JSON string ke Map
    Map<String, dynamic> userData =
        Map<String, dynamic>.from(json.decode(userDataString));
    print('user notifier');
    print(userData);
    userNotifier.value = userData;
  }
}

Future<void> saveUserData(Map<String, dynamic> newUserData) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('user', json.encode(newUserData['user']));
  print('helper');
  print(json.encode(newUserData));
  await updateUserData(); // Memperbarui ValueNotifier
}
