import 'package:frontend/src/features/core/models/book_model.dart';

class BooksState {
  List<Book> books;
  bool hasNext;
  bool isLoading;

  BooksState({
    List<Book>? books,
    bool? hasNext = true,
    bool? isLoading = false,
  })  : books = books ?? [],
        hasNext = hasNext ?? true,
        isLoading = isLoading ?? false;

  BooksState copyWith({
    List<Book>? books,
    bool? hasNext,
    bool? isLoading,
  }) {
    return BooksState(
      books: books ?? this.books,
      hasNext: hasNext ?? this.hasNext,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BooksState &&
          runtimeType == other.runtimeType &&
          books == other.books &&
          hasNext == other.hasNext &&
          isLoading == other.isLoading;

  @override
  int get hashCode => books.hashCode ^ hasNext.hashCode ^ isLoading.hashCode;
}
