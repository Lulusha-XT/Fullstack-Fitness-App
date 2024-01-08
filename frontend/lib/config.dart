class Config {
  static const String appName = "Grocery App";
  static const String apiURL = "10.0.2.2:4500";
  static const String imageURL = "http://10.0.2.2:4500/";
  static const String registorAPI = "api/users/registor";
  static const String loginAPI = "api/users/login";
  static const String getUserById = "api/users/";
  static const String updateUserById = "api/users/update";
  static const String workoutAPI = "api/workouts/registor";
  static const String bookAPI = "api/books";
  static const String bookCategoriesAPI = "api/books/categories";
  static const String gymAPI = "api/gym";
  static const String getGymById = "api/gym/";
  static const String getGymProviderByUserId = "api/gym/provider/";
  static const String getGymUserByGymId = "api/gym/user/";
  static const String getGymUserCountByGymId = "api/gym/usercount/";
  static const String gymPostAPI = "api/gympost/post/";
  static const String likeGymPostAPI = "api/gympost/likeGymPost";
  static const String getLikeGymPostAPI = "api/gympost/likeGymPost";
  static const String gymJoinAPI = "api/users/join";
  static const String gymLeaveAPI = "api/users/leave";
  static const int pageSize = 10;
  static const String currency = "BR";
  static const String likeBookEndpoint = "api/users/likeBook";
}
