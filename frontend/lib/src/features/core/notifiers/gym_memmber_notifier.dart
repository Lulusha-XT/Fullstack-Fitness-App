import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/features/core/services/gym_service.dart';
import 'package:frontend/src/features/core/states/gym_memmber_state.dart';

class GymMemmbersNotifier extends StateNotifier<GymsMemberState> {
  GymMemmbersNotifier(this._gymService) : super(GymsMemberState());
  final GymService _gymService;

  Future<void> getGymMember(int gymId) async {
    if (state.isLoading || !state.hasNext) {
      return;
    }

    Future.delayed(const Duration(microseconds: 1500), () {
      state = state.copyWith(isLoading: true);
    });
    // var filterModel = _filterModel.copyWith(
    //   paginationModel: PaginationModel(page: _page, pageSize: 10),
    // );
    final gymMember = await _gymService.getMemberUsersData(gymId);
    final newGymMember = [...state.gymMember, ...gymMember!];
    if (gymMember.length % 10 != 0 || gymMember.isEmpty) {
      state = state.copyWith(hasNext: false);
    }
    Future.delayed(const Duration(microseconds: 1500), () {
      state = state.copyWith(gymMember: newGymMember);
      //  _page++;
      state = state.copyWith(isLoading: false);
    });
  }
}
