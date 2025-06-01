class UserModel {
  final bool status;
  final String message;
  final String token;
  final User user;

  UserModel({
    required this.status,
    required this.message,
    required this.token,
    required this.user,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'],
      message: json['message'],
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String? image;
  final String? gender;
  final bool isPremium;
  final int limitSearch;
  final String? birthDate;
  final String? premiumExpiration;
  final String? emailVerifiedAt;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.image,
    this.gender,
    required this.isPremium,
    required this.limitSearch,
    this.birthDate,
    this.premiumExpiration,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      gender: json['gender'],
      isPremium: json['is_premium'],
      limitSearch: json['limitSearch'],
      birthDate: json['birth_date'],
      premiumExpiration: json['premium_expiration'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
