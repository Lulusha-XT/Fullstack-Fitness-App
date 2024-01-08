import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config.dart';
import 'package:frontend/src/features/authentication/models/user_model.dart';
import 'package:frontend/src/features/core/models/gym_model.dart';
import 'package:frontend/src/features/core/models/gym_post.dart';
import 'package:frontend/src/utils/shared_service.dart';
import 'package:http/http.dart' as http;

final gymService = Provider((ref) => GymService());

class GymService {
  static var client = http.Client();

  Future<List<Gym>?> getGyms() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.gymAPI);

    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return gymFromJson(data["data"]);
    } else {
      print(response);
      return null;
    }
  }

  Future<bool> joinGym(int gymId) async {
    var loginDetails = await SharedService.loginDetails();
    var token = loginDetails?.data.token.toString();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include the token in the headers
    };
    var url = Uri.http(Config.apiURL, '${Config.gymJoinAPI}/$gymId');

    var response = await client.post(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // Assuming the response contains a success indicator (e.g., 'success': true)
      if (data.containsKey('data') && data['data'] == true) {
        return true; // Gym joining was successful
      } else {
        return false; // Gym joining failed
      }
    } else {
      print(response);
      return false; // Gym joining failed due to an error
    }
  }

  Future<bool> leaveGym(int gymId) async {
    var loginDetails = await SharedService.loginDetails();
    var token = loginDetails?.data.token.toString();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include the token in the headers
    };
    var url = Uri.http(Config.apiURL, '${Config.gymLeaveAPI}/$gymId');

    var response = await client.post(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // Assuming the response contains a success indicator (e.g., 'success': true)
      if (data.containsKey('data') && data['data'] == true) {
        return true; // Gym joining was successful
      } else {
        return false; // Gym joining failed
      }
    } else {
      print(response);
      return false; // Gym joining failed due to an error
    }
  }

  Future<String?> getGymUserCount(int gymId) async {
    var loginDetails = await SharedService.loginDetails();
    var token = loginDetails?.data.token.toString();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include the token in the headers
    };
    var url = Uri.http(Config.apiURL, '${Config.getGymUserCountByGymId}$gymId');

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      // Assuming the response contains a success indicator (e.g., 'success': true)
      if (data.containsKey('data') && data['data'] != null) {
        return data['data']; // Gym joining was successful
      } else {
        return null; // Gym joining failed
      }
    } else {
      print("Response Body : ${response.body}");
      return null; // Gym joining failed due to an error
    }
  }

  Future<List<GymPost>?> getGymPostsByGymId(int gymId) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, "${Config.gymPostAPI}$gymId");

    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return gymPostFromJson(data["data"]);
    } else {
      print(response.body);
      return null;
    }
  }

  Future<List<GymPost>?> getLikedGymPostsByUserId() async {
    var loginDetails = await SharedService.loginDetails();
    var token = loginDetails?.data.token.toString();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include the token in the headers
    };

    var url = Uri.http(Config.apiURL, Config.getLikeGymPostAPI);

    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return gymPostFromJson(data["data"]);
    } else {
      print(response.body);
      return null;
    }
  }

  Future<bool?> likeGymPostsByUserId(int gymPostId) async {
    var loginDetails = await SharedService.loginDetails();
    var token = loginDetails?.data.token.toString();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token', // Include the token in the headers
    };
    var url = Uri.http(Config.apiURL, Config.likeGymPostAPI);
    var response = await client.post(
      url,
      body: jsonEncode(
        {"gym_post_id": gymPostId},
      ),
      headers: requestHeaders,
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return true;
    } else {
      print(response.body);
      return null;
    }
  }

  Future<List<Gym>?> getGymProviderDataByUserId() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeader = {
      "Content-Type": "application/json",
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}',
    };

    var url = Uri.http(
      Config.apiURL,
      "${Config.getGymProviderByUserId}${loginDetails.data.userId.toString()}",
    );

    var response = await client.get(url, headers: requestHeader);

    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body);

      var gyms = gymFromJson(data["data"]);

      return gyms;
    } else {
      return null;
    }
  }

  Future<List<UserModel>?> getMemberUsersData(int gymId) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeader = {
      "Content-Type": "application/json",
      'Authorization': 'Basic ${loginDetails!.data.token.toString()}',
    };

    var url = Uri.http(
      Config.apiURL,
      "${Config.getGymUserByGymId}$gymId",
    );

    var response = await client.get(url, headers: requestHeader);
    print(url);
    if (response.statusCode == 200) {
      print(response.body);
      var data = jsonDecode(response.body);

      var user = userModelFromJson(data["data"]);

      return user;
    } else {
      return null;
    }
  }
}
