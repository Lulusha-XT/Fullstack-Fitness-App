import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config.dart';
import 'package:frontend/src/features/core/models/book_category_model.dart';
import 'package:frontend/src/features/core/models/book_model.dart';
import 'package:http/http.dart' as http;

final bookService = Provider((ref) => BookService());

class BookService {
  static var client = http.Client();
  Future<List<CategoryModel>?> fetchCategories() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.bookCategoriesAPI);

    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return categoryModelFromJson(data["data"]);
    } else {
      print(response);
      return null;
    }
  }

  Future<List<Book>?> getBook() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiURL, Config.bookAPI);

    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return bookFromJson(data["data"]);
    } else {
      print(response);
      return null;
    }
  }

  Future<List<Book>> loadBooksFromAssets() async {
    String data = await rootBundle.loadString('json/books.json');
    List<dynamic> bookJsonList = json.decode(data);
    return bookJsonList
        .map(
          (json) => Book(
            bookId: json["bookId"],
            bookTitle: json['bookTitle'],
            bookDescription: json['bookDescription'],
            bookThumbnailImagePath: json['bookThumbnailImagePath'],
            bookFilePath: json['bookFilePath'],
            bookAuthor: json['bookAuthor'],
          ),
        )
        .toList();
  }
}
