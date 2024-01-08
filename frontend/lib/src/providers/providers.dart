import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/api/api_service.dart';
import 'package:frontend/src/features/authentication/models/user_model.dart';
import 'package:frontend/src/features/core/models/exercise_category_model.dart';
import 'package:frontend/src/features/core/notifiers/book_categoriy_notifier.dart';
import 'package:frontend/src/features/core/notifiers/book_notifiers.dart';
import 'package:frontend/src/features/core/notifiers/exercise_notifiers.dart';
import 'package:frontend/src/features/core/notifiers/gym_memmber_notifier.dart';
import 'package:frontend/src/features/core/notifiers/gym_notifiers.dart';
import 'package:frontend/src/features/core/notifiers/gyms_notifiers.dart';
import 'package:frontend/src/features/core/notifiers/gym_post_notifier.dart';
import 'package:frontend/src/features/core/notifiers/liked_gym_post_notifier.dart';
import 'package:frontend/src/features/core/notifiers/static_exercise_notifier.dart';
import 'package:frontend/src/features/core/notifiers/user_notifier.dart';
import 'package:frontend/src/features/core/services/book_service.dart';
import 'package:frontend/src/features/core/services/exercise_category_service.dart';
import 'package:frontend/src/features/core/services/gym_service.dart';
import 'package:frontend/src/features/core/states/book_categoriy_state.dart';
import 'package:frontend/src/features/core/states/book_state.dart';
import 'package:frontend/src/features/core/states/exercise_state.dart';
import 'package:frontend/src/features/core/states/gym_memmber_state.dart';
import 'package:frontend/src/features/core/states/gym_post_sate.dart';
import 'package:frontend/src/features/core/states/gym_provider_state.dart';
import 'package:frontend/src/features/core/states/gym_state.dart';
import 'package:frontend/src/features/core/states/liked_gym_post_state.dart';
import '../features/core/notifiers/video_controller_notifier.dart';
import '../features/core/states/video_state.dart';

final userProvider = StateNotifierProvider.autoDispose<UserNotifier, UserModel>(
  (ref) => UserNotifier(
    ref.watch(apiService),
  ),
);
final staticExerciseProvider = StateNotifierProvider<
    StaticExerciseCategoryNotifier, List<ExerciseCategory>>(
  (ref) => StaticExerciseCategoryNotifier(ref.watch(exerciseCategoryService)),
);

final exerciseProvider =
    StateNotifierProvider<ExerciseCategoryNotifier, ExerciseCategoryState>(
  (ref) => ExerciseCategoryNotifier(ref.watch(exerciseCategoryService)),
);
// Define a provider for BookCategoryNotifier
final bookCategoryProvider =
    StateNotifierProvider<BookCategoryNotifier, CategoryState>((ref) {
  // Initialize and return an instance of BookCategoryNotifier
  return BookCategoryNotifier(ref.watch(bookService));
});

final booksProvider = StateNotifierProvider<BookNotifier, BooksState>(
  (ref) => BookNotifier(ref.watch(bookService)),
);
final gymsProvider = StateNotifierProvider<GymsNotifier, GymsState>(
  (ref) => GymsNotifier(ref.watch(gymService)),
);

final gymMemberProvider =
    StateNotifierProvider.autoDispose<GymMemmbersNotifier, GymsMemberState>(
  (ref) => GymMemmbersNotifier(ref.watch(gymService)),
);

final gymProviderProvider =
    StateNotifierProvider<GymProviderNotifier, GymProviderState>(
  (ref) => GymProviderNotifier(ref.watch(gymService)),
);

final gymPostsProvider = StateNotifierProvider<GymPostNotifier, GymPostsState>(
  (ref) => GymPostNotifier(ref.watch(gymService)),
);

final likedGymPostsProvider =
    StateNotifierProvider<LikedGymPostNotifier, LikedGymPostsState>(
  (ref) => LikedGymPostNotifier(ref.watch(gymService)),
);
final videoControllerProvider =
    StateNotifierProvider<VideoControllerNotifier, VideoState>(
  (ref) => VideoControllerNotifier(),
);
