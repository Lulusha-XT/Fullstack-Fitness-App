import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/features/core/services/gym_service.dart';
import 'package:frontend/src/features/core/states/liked_gym_post_state.dart';

class LikedGymPostNotifier extends StateNotifier<LikedGymPostsState> {
  LikedGymPostNotifier(this._gymService) : super(LikedGymPostsState());
  final GymService _gymService;

  Future<void> getGymPostsByGymId() async {
    if (state.isLoading || !state.hasNext) {
      return;
    }
    Future.delayed(const Duration(microseconds: 1500), () {
      state = state.copyWith(isLoading: true);
    });
    // state = state.copyWith(isLoading: true);
    // var filterModel = _filterModel.copyWith(
    //   paginationModel: PaginationModel(page: _page, pageSize: 10),
    // );
    final gymsPost = await _gymService.getLikedGymPostsByUserId();
    final newGymPost = [...state.gymPost, ...gymsPost!];
    if (gymsPost.length % 10 != 0 || gymsPost.isEmpty) {
      state = state.copyWith(hasNext: false);
    }
    Future.delayed(const Duration(microseconds: 1500), () {
      state = state.copyWith(gymPost: newGymPost);
      //  _page++;
      state = state.copyWith(isLoading: false);
    });
  }

  Future<void> refreshstudent() async {
    state = state.copyWith(gymPost: [], hasNext: true);
    // _page = 1;
    await getGymPostsByGymId();
  }

  void toggleLike(int gymPostId) async {
    var reslut = await _gymService.likeGymPostsByUserId(gymPostId);
    print("Result = $reslut");
    final index =
        state.gymPost.indexWhere((gymPost) => gymPost.gymPostId == gymPostId);
    if (index >= 0) {
      final gymPost = state.gymPost[index];
      final updatedGymPost = gymPost.copyWith(isFavorite: !gymPost.isFavorite!);
      final updatedGymPosts = List.of(state.gymPost);
      updatedGymPosts[index] = updatedGymPost;
      state = state.copyWith(gymPost: updatedGymPosts);
    }
  }
}
