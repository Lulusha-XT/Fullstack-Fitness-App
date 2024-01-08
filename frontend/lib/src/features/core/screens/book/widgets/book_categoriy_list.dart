import 'package:flutter/material.dart';
import 'package:frontend/src/constants/colors.dart';
import 'package:frontend/src/features/core/models/book_category_model.dart';

class BookCategoryList extends StatefulWidget {
  const BookCategoryList({Key? key, required this.categories})
      : super(key: key);
  final List<CategoryModel> categories;
  @override
  State<BookCategoryList> createState() => _BookCategoryListState();
}

class _BookCategoryListState extends State<BookCategoryList> {
  int currentSelected = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.categories.length,
        itemBuilder: (ctx, i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentSelected = i;
                });
              },
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: currentSelected == i
                      ? AppColors.cDarkGrey.withOpacity(0.8)
                      : AppColors.cDarkColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.categories[i].categoryName!,
                      style: TextStyle(
                        fontWeight: currentSelected == i
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
