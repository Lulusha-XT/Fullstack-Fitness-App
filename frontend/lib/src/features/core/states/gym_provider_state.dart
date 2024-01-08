import 'package:frontend/src/features/core/models/gym_model.dart';

class GymProviderState {
  List<Gym> gymProvider;
  bool hasNext;
  bool isLoading;

  GymProviderState({
    List<Gym>? gymProvider,
    bool? hasNext = true,
    bool? isLoading = false,
  })  : gymProvider = gymProvider ?? [],
        hasNext = hasNext ?? true,
        isLoading = isLoading ?? false;

  GymProviderState copyWith({
    List<Gym>? gymProvider,
    bool? hasNext,
    bool? isLoading,
  }) {
    return GymProviderState(
      gymProvider: gymProvider ?? this.gymProvider,
      hasNext: hasNext ?? this.hasNext,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GymProviderState &&
          runtimeType == other.runtimeType &&
          gymProvider == other.gymProvider &&
          hasNext == other.hasNext &&
          isLoading == other.isLoading;

  @override
  int get hashCode =>
      gymProvider.hashCode ^ hasNext.hashCode ^ isLoading.hashCode;
}
