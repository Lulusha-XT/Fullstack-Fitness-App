import 'dart:convert';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config.dart';
import 'package:frontend/main.dart';
import 'package:frontend/src/features/authentication/models/user_model.dart';
import 'package:frontend/src/features/core/models/login_response_model.dart';
import 'package:frontend/src/utils/shared_service.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

//we use global reference our provider state of the provider is ApiService
final apiService = Provider((ref) => ApiService());

class ApiService {
  static var client = http.Client();

  static Future<bool> registerUser(UserModel user) async {
    Map<String, String> requestHeader = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.registorAPI);

    var respons = await client.post(
      url,
      headers: requestHeader,
      body: jsonEncode(user.toJosn()),
    );
    if (respons.statusCode == 200) {
      print("Response = ${respons.body}");
      await SharedService.setLoginDetails(
        loginResponseModelJson(respons.body),
      );
      return true;
    } else {
      print("Response = ${respons.body}");
      return false;
    }
  }

  static Future<bool> login(String email, String password) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.loginAPI);
    var respons = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
        {"email": email, "password": password},
      ),
    );
    if (respons.statusCode == 200) {
      print("Response = ${respons.body}");
      await SharedService.setLoginDetails(
        loginResponseModelJson(respons.body),
      );
      return true;
    } else {
      print("Response = ${respons.body}");
      return false;
    }
  }

  Future<UserModel?> getUsersData() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeader = {
      "Content-Type": "application/json",
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}',
    };

    var url = Uri.http(
      Config.apiURL,
      "${Config.getUserById}${loginDetails.data.userId.toString()}",
    );

    var response = await client.get(url, headers: requestHeader);

    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body);

      UserModel user = UserModel.fromJson(data["data"]);

      return user;
    } else {
      return null;
    }
  }

  Future<bool> updateProfile(UserModel user, File? imageFile) async {
    try {
      var loginDetails = await SharedService.loginDetails();
      var token = loginDetails?.data.token.toString();

      var request = http.MultipartRequest(
        'PUT',
        Uri.http(Config.apiURL, Config.updateUserById),
      );

      // Set request headers
      request.headers['Authorization'] = 'Basic $token';

      // Set request fields
      request.fields['full_name'] = user.fullName;
      request.fields['gender'] = user.gender!;
      request.fields['age'] = user.age.toString();
      request.fields['height'] = user.height.toString();
      request.fields['weight'] = user.weight.toString();
      request.fields['email'] = user.email;
      request.fields['phone_number'] = user.phoneNo;
      request.fields['aim'] = user.aim!;
      request.fields['activity_extent'] = user.activityExtent!;
      request.fields['birthday'] = user.birthday!;

      // Set profile picture
      if (imageFile != null) {
        var profilePicField = await http.MultipartFile.fromPath(
          'profilePicture',
          imageFile.path,
        );
        request.files.add(profilePicField);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return true;
      } else if (response.statusCode == 401) {
        navigatorKey.currentState
            ?.pushNamedAndRemoveUntil("/login", (route) => false);
        return false;
      } else {
        return false;
      }
    } catch (e) {
      print('Error updating profile: $e');
      return false;
    }
  }

  static Future<bool> likeBook(int bookId) async {
    try {
      var loginDetails = await SharedService.loginDetails();
      Map<String, dynamic> data = {
        'book_id': bookId,
      };

      var url = Uri.http(
        Config.apiURL,
        Config.likeBookEndpoint, // Replace with your like book endpoint
      );

      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Basic ${loginDetails!.data.token.toString()}',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print(response.body);
        var responseData = jsonDecode(response.body);
        // Assuming the API response contains a "success" field
        if (responseData['success'] == true) {
          return true; // Book liked successfully
        } else {
          return false; // Book like operation failed
        }
      } else {
        return false; // Request to like book failed
      }
    } catch (e) {
      // Handle network errors here
      print("Network error: $e");
      return false; // Network error occurred
    }
  }

//   _likePost() async {
//   String endPoint = isLike == 0 ? 'likebook' : 'disLikebook';
//   Map<String, dynamic> data = {
//     'user_id': userId.toString(),
//     'book_id': widget.bookInfo!.bookId.toString(),
//   };

//   try {
//     Response response = await Dio().post(
//       yourServerApiEndpoint, // Replace with your server's API endpoint URL
//       data: data,
//     );

//     if (response.statusCode == 200) {
//       // Update the like status locally.
//       setState(() {
//         isLike = isLike == 0 ? 1 : 0; // Toggle like status
//       });
//     } else {
//       // Handle errors here
//       print("Failed to like/dislike the book.");
//     }
//   } catch (e) {
//     // Handle network errors here
//     print("Network error: $e");
//   }
// }
}
