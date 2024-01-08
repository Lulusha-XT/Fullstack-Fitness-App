List<CategoryModel> categoryModelFromJson(dynamic str) =>
    List<CategoryModel>.from((str).map((x) => CategoryModel.fromJson(x)));

class CategoryModel {
  int categoryId;
  String? categoryName;

  CategoryModel({
    required this.categoryId,
    this.categoryName,
  });

  // Factory constructor to create a CategoryModel instance from a map (usually from JSON)
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['category_id'],
      categoryName: json['category_name'],
    );
  }

  // Convert the CategoryModel instance to a map (usually for JSON serialization)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    return data;
  }
}
