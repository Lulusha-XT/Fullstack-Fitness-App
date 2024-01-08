import 'package:frontend/config.dart';

List<UserModel> userModelFromJson(dynamic str) =>
    List<UserModel>.from((str).map((x) => UserModel.fromJson(x)));

class UserModel {
  final int? id;
  final String fullName;
  String? gender;
  int? age;
  int? height;
  int? weight;
  final String email;
  final String phoneNo;
  String? aim;
  String? activityExtent;
  String? birthday;
  final String? password;
  final String? profilePicture;

  UserModel({
    this.id,
    required this.email,
    this.password,
    required this.fullName,
    this.gender,
    this.age,
    this.height,
    this.weight,
    required this.phoneNo,
    this.aim,
    this.activityExtent,
    this.profilePicture,
    this.birthday,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["user_id"],
      fullName: json['full_name'],
      gender: json['gender'],
      birthday: json["birthday"],
      age: json['age'],
      height: json['height'],
      weight: json['weightt'],
      email: json["email"],
      phoneNo: json["phone_number"],
      password: json["user_password"],
      aim: json["aim"],
      activityExtent: json["activity_extent"],
      profilePicture: json["profile_picture"],
    );
  }
  toJosn() {
    return {
      "full_name": fullName,
      "gender": gender,
      "birthday": birthday,
      "age": age,
      "height": height,
      "weight": weight,
      "email": email,
      "phone_number": phoneNo,
      "user_password": password,
      "aim": aim,
      "activity_extent": activityExtent,
      "profile_picture": profilePicture,
    };
  }

  String get fullImagePath =>
      profilePicture!.isNotEmpty ? "${Config.imageURL}$profilePicture" : '';
}
