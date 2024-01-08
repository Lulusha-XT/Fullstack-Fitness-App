import 'package:frontend/src/features/core/models/gym_model.dart';

class GymsState {
  List<Gym> gyms;
  bool hasNext;
  bool isLoading;

  GymsState({
    List<Gym>? gyms,
    bool? hasNext = true,
    bool? isLoading = false,
  })  : gyms = gyms ?? [],
        hasNext = hasNext ?? true,
        isLoading = isLoading ?? false;

  GymsState copyWith({
    List<Gym>? gyms,
    bool? hasNext,
    bool? isLoading,
  }) {
    return GymsState(
      gyms: gyms ?? this.gyms,
      hasNext: hasNext ?? this.hasNext,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GymsState &&
          runtimeType == other.runtimeType &&
          gyms == other.gyms &&
          hasNext == other.hasNext &&
          isLoading == other.isLoading;

  @override
  int get hashCode => gyms.hashCode ^ hasNext.hashCode ^ isLoading.hashCode;
}
