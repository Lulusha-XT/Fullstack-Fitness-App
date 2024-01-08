import 'package:frontend/src/features/core/models/gym_post.dart';

class LikedGymPostsState {
  List<GymPost> gymPost;
  bool hasNext;
  bool isLoading;

  LikedGymPostsState({
    List<GymPost>? gymPost,
    bool? hasNext = true,
    bool? isLoading = false,
  })  : gymPost = gymPost ?? [],
        hasNext = hasNext ?? true,
        isLoading = isLoading ?? false;

  LikedGymPostsState copyWith({
    List<GymPost>? gymPost,
    bool? hasNext,
    bool? isLoading,
  }) {
    return LikedGymPostsState(
      gymPost: gymPost ?? this.gymPost,
      hasNext: hasNext ?? this.hasNext,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LikedGymPostsState &&
          runtimeType == other.runtimeType &&
          gymPost == other.gymPost &&
          hasNext == other.hasNext &&
          isLoading == other.isLoading;

  @override
  int get hashCode => gymPost.hashCode ^ hasNext.hashCode ^ isLoading.hashCode;
}
