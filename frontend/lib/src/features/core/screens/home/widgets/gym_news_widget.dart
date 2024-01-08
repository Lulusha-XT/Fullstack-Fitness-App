import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/features/core/models/gym_model.dart';
import 'package:frontend/src/features/core/models/gym_post.dart';
import 'package:frontend/src/features/core/screens/gym_profile/gym_profile_screen.dart';
import 'package:frontend/src/providers/providers.dart';
import 'package:get/get.dart';

class GymNewsWidget extends StatelessWidget {
  const GymNewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        sliver: gymProviderData(context));
  }

  Widget gymProviderData(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final gymProviderState = ref.watch(gymProviderProvider);
        if (gymProviderState.gymProvider.isEmpty) {
          ref.read(gymProviderProvider.notifier).getGymProviderByUserId();
          if (!gymProviderState.hasNext && !gymProviderState.isLoading) {
            return SliverToBoxAdapter(
              child: Center(
                child: Text("noGym".tr),
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
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GymProfileScreen(gym: gym)),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                gym.gymImage != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(
                          gym.gymImage!,
                        ),
                        radius: 25,
                      )
                    : const CircleAvatar(
                        radius: 25,
                        child: Icon(Icons.sports_gymnastics),
                      ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      gym.gymName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 5),
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
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 200,
            padding: const EdgeInsets.only(top: 20, left: 20),
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
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(gymPost.fullImagePath),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.orange,
                ),
                child: FavoriteIcon(gymPost: gymPost),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({super.key, required this.gymPost});
  final GymPost gymPost;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final gymPostsProviderNotifier = ref.watch(gymPostsProvider.notifier);
      return GestureDetector(
        onTap: () async {
          gymPostsProviderNotifier.toggleLike(gymPost.gymPostId!);
        },
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 30.0,
                      height: 30.0,
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: Icon(
                          Icons.favorite_rounded,
                          color: gymPost.isFavorite!
                              ? Colors.red
                              : AppColors.cWhiteClr,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
