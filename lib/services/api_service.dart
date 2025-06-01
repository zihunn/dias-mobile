import 'dart:io';

import 'package:DiAs/models/siki/siki_model.dart';
import 'package:DiAs/models/slki/detail_slki_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/sdki/detail_sdki_model.dart';
import '../models/sdki/sdki_model.dart';
import '../models/search/deatail_searach_model.dart';
import '../models/search/search_model.dart';
import '../models/siki/detail_siki_model.dart';
import '../models/slki/slki_model.dart';
import '../utils/helpers.dart';

class ApiService {
  final String baseUrl = 'https://dias.lkp-ppik.id/api';

  Future<Map<String, dynamic>> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register user');
    }
  }

  Future<Map<String, dynamic>> verifyOtp(
      {required String email,
      required String otpCode,
      required String name,
      required String password}) async {
    final url = Uri.parse('$baseUrl/verify-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'otp_code': otpCode,
        'name': name,
        'password': password
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to verify OTP');
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login'); // Pastikan endpoint benar
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Respons berhasil, parsing JSON dan kirim kembali sebagai Map
        print('Service Login');
        print(response.body);
        return jsonDecode(response.body);
      } else {
        // Jika gagal, parsing pesan error sesuai format BLoC
        return {
          'status': false,
          'message': jsonDecode(response.body)['message'] ??
              'Login gagal, periksa kredensial Anda.',
        };
      }
    } catch (e) {
      // Tangani error koneksi atau error lain
      return {
        'status': false,
        'message': 'Gagal terhubung ke server. Periksa koneksi Anda.',
      };
    }
  }

  Future<Map<String, dynamic>> updateProfile({
    required String token,
    required String name,
    String? gender,
    String? birthDate,
    File? profileImage,
  }) async {
    final url = Uri.parse('$baseUrl/user/update');
    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer $token'
      ..headers['Content-Type'] = 'multipart/form-data'
      ..fields['name'] = name;

    if (gender != null) request.fields['gender'] = gender;
    if (birthDate != null) request.fields['birth_date'] = birthDate ?? '';

    if (profileImage != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'profile_image',
        profileImage.path,
      ));
    }

    final response = await request.send();
    final responseData = await http.Response.fromStream(response);

    print(responseData.statusCode);
    if (responseData.statusCode == 200) {
      final decodedData = jsonDecode(responseData.body);
      print('api update');
      print(decodedData['user']);
      return {'statusCode': 200, 'userData': decodedData};
    } else {
      // Parsing pesan error dari respons jika tersedia
      final errorData = jsonDecode(responseData.body);
      print(errorData['message']);
      final errorMessage = errorData['message'] ?? 'Failed to update profile';
      throw Exception(errorMessage);
    }
  }

  static Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    print(prefs.getString('user'));

    if (token == null) {
      return null; // Return jika tidak ada token
    }

    final response = await http.get(
      Uri.parse('https://dias.lkp-ppik.id/api/user'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print(response.statusCode);

    if (response.statusCode == 200) {
      final userData = jsonDecode(response.body) as Map<String, dynamic>;

      // Simpan data user baru ke SharedPreferences
      await prefs.setString('user', jsonEncode(userData));

      // Memanggil fungsi updateUserData untuk memperbarui ValueNotifier
      await updateUserData();

      print('getuser data');
      print(userData);
      return userData;
    } else {
      // Kembalikan null jika pengambilan data user gagal
      return null;
    }
  }

  Future<Map<String, dynamic>> fetchTransactionsByUserId(int userId) async {
    final url = Uri.parse(
        '$baseUrl/payment/history/$userId'); // Menambahkan userId ke URL

    try {
      // Ambil token dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('No token found');
      }

      // Menambahkan header Authorization dengan Bearer token
      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type':
            'application/json', // Opsional, tergantung kebutuhan API Anda
      };

      final response = await http.get(url, headers: headers);

      print("ini print get api history");
      print(url);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        print(responseBody);
        return responseBody;
      } else {
        throw Exception('Failed to load transactions');
      }
    } catch (e) {
      print(e);
      throw Exception('Error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> fetchDetailHistoryTransaction(
      String orderId) async {
    final url = Uri.parse(
        '$baseUrl/payment/detail/$orderId'); // Menambahkan userId ke URL

    try {
      // Ambil token dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) {
        throw Exception('No token found');
      }

      final headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(url, headers: headers);

      print("ini print get api detail history");
      print(url);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        print(responseBody);
        return responseBody;
      } else {
        throw Exception('Failed to load detail transactions');
      }
    } catch (e) {
      print(e);
      throw Exception('Error: ${e.toString()}');
    }
  }

  Future<SdkiModel> fetchSdkiData({required int page}) async {
    // Ambil token dari SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('No token found');
    }

    // Headers untuk otentikasi
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    // Permintaan HTTP dengan headers
    final response = await http.get(
      Uri.parse('$baseUrl/sdki?page=$page'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return SdkiModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<SlkiModel> fetchSlkiData({required int page}) async {
    // Ambil token dari SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('No token found');
    }

    // Headers untuk otentikasi
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    // Permintaan HTTP dengan headers
    final response = await http.get(
      Uri.parse('$baseUrl/slki?page=$page'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return SlkiModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<SikiModel> fetchSikiData({required int page}) async {
    // Ambil token dari SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('No token found');
    }

    // Headers untuk otentikasi
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    // Permintaan HTTP dengan headers
    final response = await http.get(
      Uri.parse('$baseUrl/siki?page=$page'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      print(response.body);
      return SikiModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<DetailSdkiModel?> fetchSdkiDetail(String idSdki) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("Token is not available");
    }

    final response = await http.get(
      Uri.parse("$baseUrl/sdki/$idSdki"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return DetailSdkiModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<DetailSlki> fetchSlkiDetail(String idSdki) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("Token is not available");
    }

    final response = await http.get(
      Uri.parse("$baseUrl/slki/$idSdki"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return DetailSlki.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load data");
    }
  }

  Future<DetailSikiModel> fetchSikiDetail(String idSiki) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception("Token is not available");
    }

    final response = await http.get(
      Uri.parse("$baseUrl/siki/$idSiki"),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      return DetailSikiModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load data");
    }
  }

// Fungsi untuk mengirimkan OTP reset password
  Future<Map<String, dynamic>> sendPasswordResetOtp(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/otp-reset-password');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = json.encode({'email': email});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'status': false,
          'message': 'Failed to send OTP. Please try again.'
        };
      }
    } catch (e) {
      return {
        'status': false,
        'message': 'Something went wrong. Please try again later.'
      };
    }
  }

  // Fungsi untuk memverifikasi OTP dan mereset password
  Future<Map<String, dynamic>> resetPasswordWithOtp(
      String email, String otp, String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/reset-password');

    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = json.encode({
      'email': email,
      'otp_code': otp,
      'new_password': newPassword,
      'new_password_confirmation': newPassword, // Konfirmasi password
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return {
          'status': false,
          'message': 'Password reset failed. Please try again.'
        };
      }
    } catch (e) {
      return {
        'status': false,
        'message': 'Something went wrong. Please try again later.'
      };
    }
  }

  Future<SearchModels> fetchSearchResults(String query) async {
    // Get the token from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('No token found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/search?query=$query'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return SearchModels.fromJson(json.decode(response.body));
    } else if (response.statusCode == 403) {
      throw Exception('Limit pencarian Anda sudah habis');
    } else {
      throw Exception('Failed to load search results');
    }
  }

  Future<ApiResponse> fetchSearchDetail(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token =
        prefs.getString('token'); // Ambil token dari SharedPreferences

    if (token == null) {
      throw Exception('Token not found');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/search/$id'),
      headers: {
        'Authorization': 'Bearer $token', // Sertakan token dalam header
      },
    );

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
