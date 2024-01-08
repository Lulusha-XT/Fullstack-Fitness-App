class FoodModel {
  final String name;
  final String imageUrl;
  final double carbohydrates;
  final double protein;
  final double fat;
  final bool isSeasoning;
  bool isSelected;

  FoodModel({
    required this.name,
    required this.imageUrl,
    required this.carbohydrates,
    required this.protein,
    required this.fat,
    required this.isSeasoning,
    this.isSelected = false,
  });
  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      name: json['name'],
      imageUrl: json['imageUrl'],
      carbohydrates: json['carbohydrates'],
      protein: json['protein'],
      fat: json['fat'],
      isSeasoning: json["isSeasoning"],
    );
  }
}
