import 'package:frontend/src/features/authentication/models/user_model.dart';

class GymsMemberState {
  List<UserModel> gymMember;
  bool hasNext;
  bool isLoading;

  GymsMemberState({
    List<UserModel>? gymMember,
    bool? hasNext = true,
    bool? isLoading = false,
  })  : gymMember = gymMember ?? [],
        hasNext = hasNext ?? true,
        isLoading = isLoading ?? false;

  GymsMemberState copyWith({
    List<UserModel>? gymMember,
    bool? hasNext,
    bool? isLoading,
  }) {
    return GymsMemberState(
      gymMember: gymMember ?? this.gymMember,
      hasNext: hasNext ?? this.hasNext,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GymsMemberState &&
          runtimeType == other.runtimeType &&
          gymMember == other.gymMember &&
          hasNext == other.hasNext &&
          isLoading == other.isLoading;

  @override
  int get hashCode =>
      gymMember.hashCode ^ hasNext.hashCode ^ isLoading.hashCode;
}
