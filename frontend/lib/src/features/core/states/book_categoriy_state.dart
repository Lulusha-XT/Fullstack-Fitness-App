import 'package:frontend/src/features/core/models/book_category_model.dart';

class CategoryState {
  final List<CategoryModel> categories; // List of CategoryModel instances
  bool hasNext;
  bool isLoading;

  CategoryState({
    this.categories = const [],
    this.hasNext = true,
    this.isLoading = false,
  });

  // Create a copy of the state with updated categories
  CategoryState copyWith({
    List<CategoryModel>? categories,
    bool? hasNext = true,
    bool? isLoading = false,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      hasNext: hasNext ?? this.hasNext,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
