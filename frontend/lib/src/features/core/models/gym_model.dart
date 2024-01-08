List<Gym> gymFromJson(dynamic str) =>
    List<Gym>.from((str).map((x) => Gym.fromJson(x)));

class Gym {
  final int? gymId;
  final String gymName;
  final String gymMonthlyPayment;
  final String gymLocation;
  final String? gymImage;

  Gym({
    this.gymId,
    required this.gymName,
    required this.gymMonthlyPayment,
    required this.gymLocation,
    this.gymImage,
  });

  factory Gym.fromJson(Map<String, dynamic> json) {
    return Gym(
      gymId: json['gym_id'],
      gymName: json['gym_name'],
      gymMonthlyPayment: json['gym_monthly_payment'],
      gymLocation: json['gym_location'],
      gymImage: json['gym_image'],
    );
  }
}
