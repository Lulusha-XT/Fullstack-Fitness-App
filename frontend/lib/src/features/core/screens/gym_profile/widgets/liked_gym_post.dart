import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/features/core/models/gym_post.dart';
import 'package:frontend/src/providers/providers.dart';

class LikedGymPostWidget extends StatelessWidget {
  const LikedGymPostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final likedGymsPostState = ref.watch(likedGymPostsProvider);
        if (likedGymsPostState.gymPost.isEmpty) {
          ref.watch(likedGymPostsProvider.notifier).getGymPostsByGymId();
          if (!likedGymsPostState.hasNext && !likedGymsPostState.isLoading) {
            return const SliverToBoxAdapter(
              child: Center(
                child: Text("No Liked Post"),
              ),
            );
          }
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        } else {
          // show gym post
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: likedGymsPostState.gymPost.length,
              (BuildContext context, int index) {
                final gymPostItem = likedGymsPostState.gymPost[index];
                return makePost(context, gymPostItem);
              },
            ),
          );
        }
      },
    );
  }

  Widget makePost(BuildContext context, GymPost gymPost) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  gymPost.createdAt,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.cGrey,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  gymPost.postDescription,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            Container(
              height: 200,
              padding: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => SinglePost(
                  //       post: post,
                  //       image: post.photos[1],
                  //     ),
                  //   ),
                  // );
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(gymPost.fullImagePath),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.orange,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 30.0,
                                  height: 30.0,
                                  padding: const EdgeInsets.all(5),
                                  child: const Center(
                                    child: Icon(
                                      Icons.favorite,
                                      color: AppColors.cWhiteClr,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
