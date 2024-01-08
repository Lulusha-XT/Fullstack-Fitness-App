import 'package:frontend/src/features/core/models/gym_post.dart';

class GymPostsState {
  List<GymPost> gymPost;
  bool hasNext;
  bool isLoading;

  GymPostsState({
    List<GymPost>? gymPost,
    bool? hasNext = true,
    bool? isLoading = false,
  })  : gymPost = gymPost ?? [],
        hasNext = hasNext ?? true,
        isLoading = isLoading ?? false;

  GymPostsState copyWith({
    List<GymPost>? gymPost,
    bool? hasNext,
    bool? isLoading,
  }) {
    return GymPostsState(
      gymPost: gymPost ?? this.gymPost,
      hasNext: hasNext ?? this.hasNext,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GymPostsState &&
          runtimeType == other.runtimeType &&
          gymPost == other.gymPost &&
          hasNext == other.hasNext &&
          isLoading == other.isLoading;

  @override
  int get hashCode => gymPost.hashCode ^ hasNext.hashCode ^ isLoading.hashCode;
}
