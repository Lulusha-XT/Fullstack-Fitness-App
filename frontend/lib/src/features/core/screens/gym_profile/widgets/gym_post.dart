import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/features/core/models/gym_model.dart';
import 'package:frontend/src/features/core/models/gym_post.dart';
import 'package:frontend/src/providers/providers.dart';

class GymPostWidget extends StatelessWidget {
  const GymPostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return gymProviderData(context);
  }

  Widget gymProviderData(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final gymProviderState = ref.watch(gymProviderProvider);
        if (gymProviderState.gymProvider.isEmpty) {
          ref.read(gymProviderProvider.notifier).getGymProviderByUserId();
          if (!gymProviderState.hasNext && !gymProviderState.isLoading) {
            return const SliverToBoxAdapter(
              child: Center(
                child: Text("No Gym"),
              ),
            );
          }
          // fetch gym data
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          // show gym post
          return gymPostData(context, gymProviderState.gymProvider[0]);
        }
      },
    );
  }

  Widget gymPostData(BuildContext context, Gym gym) {
    return Consumer(
      builder: (context, ref, _) {
        final gymsPostState = ref.watch(gymPostsProvider);
        if (gymsPostState.gymPost.isEmpty) {
          ref.watch(gymPostsProvider.notifier).getGymPostsByGymId(gym.gymId!);
          if (!gymsPostState.hasNext && !gymsPostState.isLoading) {
            return const SliverToBoxAdapter(
              child: Center(
                child: Text("No Post"),
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
              childCount: gymsPostState.gymPost.length,
              (BuildContext context, int index) {
                final gymPostItem = gymsPostState.gymPost[index];
                return makePost(context, gymPostItem, gym);
              },
            ),
          );
        }
      },
    );
  }

  Widget makePost(BuildContext context, GymPost gymPost, Gym gym) {
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
