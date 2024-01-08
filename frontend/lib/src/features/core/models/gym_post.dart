import 'package:frontend/config.dart';

List<GymPost> gymPostFromJson(dynamic str) =>
    List<GymPost>.from((str).map((x) => GymPost.fromJson(x)));

class GymPost {
  final int? gymPostId;
  final int gymId;
  final String postDescription;
  final String postImagePath;
  final String createdAt;
  bool? isFavorite;

  GymPost({
    this.gymPostId,
    required this.gymId,
    required this.postDescription,
    required this.postImagePath,
    this.isFavorite = false,
    required this.createdAt,
  });

  factory GymPost.fromJson(Map<String, dynamic> json) {
    return GymPost(
      gymPostId: json['id'],
      gymId: json['gym_id'],
      postDescription: json['post_description'],
      postImagePath: json['post_image_path'],
      createdAt: json['created_at'],
    );
  }
  GymPost copyWith({
    int? gymPostId,
    int? gymId,
    String? postImagePath,
    String? postDescription,
    bool? isFavorite,
    String? createdAt,
  }) {
    return GymPost(
      gymPostId: gymPostId ?? this.gymPostId,
      gymId: gymId ?? this.gymId,
      postImagePath: postImagePath ?? this.postImagePath,
      postDescription: postDescription ?? this.postDescription,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  String get fullImagePath =>
      postImagePath.isNotEmpty ? "${Config.imageURL}$postImagePath" : '';
}
