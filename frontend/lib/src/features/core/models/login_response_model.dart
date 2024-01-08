import 'dart:convert';

LoginResponseModel loginResponseModelJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  late final String message;
  late final Data data;
  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    data = Data.fromJson(json["data"]);
  }
  Map<String, dynamic> toJson() {
    final datas = <String, dynamic>{};
    datas["message"] = message;
    datas["data"] = data.toJson();
    return datas;
  }
}

class Data {
  late final String fullName;
  late final String email;
  late final int userId;
  late final String token;
  Data({
    required this.fullName,
    required this.email,
    required this.userId,
    required this.token,
  });
  Data.fromJson(Map<String, dynamic> json) {
    fullName = json["full_name"];
    email = json["email"];
    userId = json["user_id"];
    token = json["token"];
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data["full_name"] = fullName;
    data["email"] = email;
    data["user_id"] = userId;
    data["token"] = token;
    return data;
  }
}
