import 'package:frontend/config.dart';

List<Book> bookFromJson(dynamic str) =>
    List<Book>.from((str).map((x) => Book.fromJson(x)));

class Book {
  final int? bookId;
  final String bookTitle;
  final String bookDescription;
  final String bookThumbnailImagePath;
  final String bookFilePath;
  final String bookAuthor;
  final int? bookCategoryId;

  Book({
    this.bookId,
    required this.bookTitle,
    required this.bookDescription,
    required this.bookThumbnailImagePath,
    required this.bookFilePath,
    required this.bookAuthor,
    this.bookCategoryId,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      bookId: json["book_id"],
      bookTitle: json["book_title"],
      bookDescription: json["book_description"],
      bookThumbnailImagePath: json["book_thumbnail"],
      bookFilePath: json["book_file_path"],
      bookAuthor: json["book_author_name"],
      bookCategoryId: json["book_category_id"],
    );
  }

  String get fullImagePath => Config.imageURL + bookThumbnailImagePath;
}
