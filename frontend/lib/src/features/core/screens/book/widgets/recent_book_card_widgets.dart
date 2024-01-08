import 'package:flutter/material.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/features/core/models/book_model.dart';
import 'package:frontend/src/features/core/screens/book/detail_book/detail_book_screen.dart';
import 'package:get/get.dart';

class RecentBookCardWidget extends StatelessWidget {
  const RecentBookCardWidget({Key? key, required this.book}) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailBookPage(bookInfo: book),
          ),
        );
      },
      child: SizedBox(
        width: 200.0,
        height: 200.0,
        child: Stack(
          children: [
            Positioned(
              top: 35,
              child: Material(
                elevation: 0.0,
                child: Container(
                  height: 180.0,
                  width: width,
                  decoration: BoxDecoration(
                    color:
                        context.isDarkMode ? AppColors.cDarkGrey : Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Card(
                elevation: 10.0,
                shadowColor: context.isDarkMode
                    ? AppColors.cDarkColor
                    : AppColors.cWhiteClr,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: SizedBox(
                    height: 200,
                    width: 150,
                    child: Image.network(
                      book.fullImagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 45,
              left: width * 0.4,
              child: Container(
                height: 200,
                width: 200,
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.bookTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontFamily: "Avenir",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      book.bookAuthor,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: "Avenir",
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Divider(color: Colors.orange),
                    Text(
                      '${"categories".tr}: ${book.bookId}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "Avenir",
                        color: AppColors.cGrey,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Rating: ${book.bookId}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "Avenir",
                        color: AppColors.cGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
