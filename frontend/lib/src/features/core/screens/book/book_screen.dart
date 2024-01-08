import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/common_widgets/app_bar/app_bar.dart';
import 'package:frontend/src/features/core/models/book_category_model.dart';
import 'package:frontend/src/features/core/models/book_model.dart';
import 'package:frontend/src/features/core/screens/book/widgets/book_categoriy_list.dart';
import 'package:frontend/src/features/core/screens/book/widgets/book_category.dart';
import 'package:frontend/src/features/core/screens/book/widgets/recent_book_card_widgets.dart';
import 'package:frontend/src/providers/providers.dart';
import 'package:get/get.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("book".tr, context),
      body: _buildGetData(context),
    );
  }

  Widget _buildGetData(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final booksState = ref.watch(booksProvider);
        final categoryState = ref.watch(bookCategoryProvider);
        // if (categoryState.categories.isEmpty || booksState.books.isEmpty) {
        //   print("The categories or books are empty");
        // }
        if (categoryState.categories.isEmpty) {
          // Fetch categoriess if they are empty
          ref.read(bookCategoryProvider.notifier).fetchCategories();
          if (!categoryState.hasNext && !categoryState.isLoading) {
            return const Center(
              child: Text("No book category"),
            );
          }
          return _buildLoadingIndicator();
        } else {
          if (booksState.books.isEmpty) {
            // Fetch  books if they are empty
            ref.read(booksProvider.notifier).getBookss();
            if (!booksState.hasNext && !booksState.isLoading) {
              return const Center(
                child: Text("No book "),
              );
            }
            return _buildLoadingIndicator();
          } else {
            return _buildBody(booksState.books, categoryState.categories);
          }
        }
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildBody(List<Book> books, List<CategoryModel> categories) {
    return RefreshIndicator(
      onRefresh: () => _refresh(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // const CustomeSearchBar(),
            BookCategories(bookCategories: books),
            const SizedBox(height: 20.0),
            _buildSectionTitle("categories".tr),
            const SizedBox(height: 10.0),
            _buildBookCategories(categories),
            const SizedBox(height: 20.0),
            _buildSectionTitle("recentlyAdded".tr),
            const SizedBox(height: 20.0),
            _buildRecentBooks(books),
          ],
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    // Implement your refresh logic here
  }

  Widget _buildBookCategories(List<CategoryModel> categories) {
    // Implement how you want to display the book categories here
    // Example: return a ListView of category chips or a horizontal scrollable list
    return BookCategoryList(categories: categories);
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentBooks(List<Book> books) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: books.length,
        itemBuilder: (BuildContext context, int index) {
          return RecentBookCardWidget(book: books[index]);
        },
      ),
    );
  }
}
