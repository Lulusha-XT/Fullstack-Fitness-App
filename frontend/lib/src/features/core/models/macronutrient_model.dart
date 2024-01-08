List<Macronutrient> macronutrientFromJson(dynamic str) =>
    List<Macronutrient>.from((str).map((x) => Macronutrient.fromJson(x)));

class Macronutrient {
  double macronutrientCalorie;
  double macronutrientCarbohydrates;
  double macronutrientProtein;
  double macronutrientFat;

  Macronutrient({
    required this.macronutrientCalorie,
    required this.macronutrientCarbohydrates,
    required this.macronutrientProtein,
    required this.macronutrientFat,
  });
  factory Macronutrient.fromJson(Map<String, dynamic> json) {
    return Macronutrient(
      macronutrientCalorie: json['macronutrientCalorie'],
      macronutrientCarbohydrates: json['macronutrientCarbohydrates'],
      macronutrientProtein: json['macronutrientProtein'],
      macronutrientFat: json['macronutrientFat'],
    );
  }
}
