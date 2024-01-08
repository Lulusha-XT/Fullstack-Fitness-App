import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/features/core/services/book_service.dart';
import 'package:frontend/src/features/core/states/book_state.dart';

class BookNotifier extends StateNotifier<BooksState> {
  BookNotifier(this._bookService) : super(BooksState());
  final BookService _bookService;

  Future<void> getBookss() async {
    if (state.isLoading || !state.hasNext) {
      return;
    }
    // state = state.copyWith(isLoading: true);
    // var filterModel = _filterModel.copyWith(
    //   paginationModel: PaginationModel(page: _page, pageSize: 10),
    // );
    final books = await _bookService.getBook();
    final newBooks = [...state.books, ...books!];
    if (books.length % 10 != 0 || books.isEmpty) {
      state = state.copyWith(hasNext: false);
    }
    Future.delayed(const Duration(microseconds: 1500), () {
      state = state.copyWith(books: newBooks);
      //  _page++;
      state = state.copyWith(isLoading: false);
    });
  }

  Future<void> loadBooksFromAssets() async {
    if (state.isLoading || !state.hasNext) {
      return;
    }
    Future.delayed(const Duration(microseconds: 1500), () {
      state = state.copyWith(isLoading: true);
    });
    final books = await _bookService.loadBooksFromAssets();

    Future.delayed(const Duration(microseconds: 1500), () {
      state = state.copyWith(books: books);
      state = state.copyWith(isLoading: false);
    });
  }
}
