import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/features/core/services/book_service.dart';
import 'package:frontend/src/features/core/states/book_categoriy_state.dart';

class BookCategoryNotifier extends StateNotifier<CategoryState> {
  BookCategoryNotifier(this._bookService) : super(CategoryState());
  // Inject your _bookService service
  final BookService _bookService;
  Future<void> fetchCategories() async {
    try {
      // Implement the logic to fetch categories from your service
      if (state.isLoading || !state.hasNext) {
        return;
      }
      Future.delayed(const Duration(microseconds: 1500), () {
        state = state.copyWith(isLoading: true);
      });
      final categories = await _bookService.fetchCategories();
      final newCategories = [...state.categories, ...categories!];
      if (categories.length % 10 != 0 || categories.isEmpty) {
        state = state.copyWith(hasNext: false);
      }
      Future.delayed(const Duration(microseconds: 1500), () {
        state = state.copyWith(categories: newCategories);
        //  _page++;
        state = state.copyWith(isLoading: false);
      });
    } catch (error) {
      print("Error: ${error}");
      // Handle errors appropriately
    }
  }
}
