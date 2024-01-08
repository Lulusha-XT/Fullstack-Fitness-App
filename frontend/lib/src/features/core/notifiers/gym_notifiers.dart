import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/src/features/core/services/gym_service.dart';
import 'package:frontend/src/features/core/states/gym_provider_state.dart';

class GymProviderNotifier extends StateNotifier<GymProviderState> {
  GymProviderNotifier(this._gymService) : super(GymProviderState());
  final GymService _gymService;

  Future<void> getGymProviderByUserId() async {
    if (state.isLoading || !state.hasNext) {
      return;
    }
    Future.delayed(const Duration(microseconds: 1500), () {
      state = state.copyWith(isLoading: true);
    });
    // var filterModel = _filterModel.copyWith(
    //   paginationModel: PaginationModel(page: _page, pageSize: 10),
    // );
    final gymProviders = await _gymService.getGymProviderDataByUserId();
    final newGymProvider = [...state.gymProvider, ...gymProviders!];
    if (gymProviders.length % 10 != 0 || gymProviders.isEmpty) {
      state = state.copyWith(hasNext: false);
    }
    Future.delayed(const Duration(microseconds: 1500), () {
      state = state.copyWith(gymProvider: newGymProvider);
      //  _page++;
      state = state.copyWith(isLoading: false);
    });
  }

  Future<void> refresh() async {
    getGymProviderByUserId();
  }
}
