import 'package:e_learning_app/repository/api/expert/fetch_expert.dart';
import 'package:e_learning_app/src/features/onboarding/riverpod/login_state.dart';
import 'package:e_learning_app/src/features/search/model/expert_model.dart';
import 'package:e_learning_app/src/features/search/provider/expert_search_query_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:e_learning_app/src/features/search/provider/selected_skill_provider.dart';

class ExpertPaginationNotifier extends StateNotifier<AsyncValue<List<Data>>> {
  final Ref ref;
  final _repository = FetchExpert();

  int _currentPage = 1;
  bool _hasNextPage = true;
  bool _isLoading = false;

  ExpertPaginationNotifier(this.ref) : super(const AsyncValue.loading()) {
    fetchExperts(reset: true);
  }

  Future<void> fetchExperts({bool reset = false}) async {
    if (_isLoading) return;
    _isLoading = true;

    final token = ref.read(authTokenProvider);
    final query = ref.read(expertSearchQueryProvider);

    final selectedSkills = ref.read(selectedSkillsProvider);
    final String? skillsCsv =
    selectedSkills.isNotEmpty ? selectedSkills.join(', ') : null;

    if (token == null) {
      state = AsyncValue.error("Unauthorized", StackTrace.current);
      _isLoading = false;
      return;
    }

    if (query.isEmpty && !reset) {
      await fetchExperts(reset: true);
      _isLoading = false;
      return;
    }

    if (reset) {
      _currentPage = 1;
      _hasNextPage = true;
      state = const AsyncValue.loading();
    }

    try {
      final response = await _repository.getExperts(
        token,
        page: _currentPage,
        perPage: 10,
        query: query.isNotEmpty ? query : null,
        skills: skillsCsv,
      );

      final fetchedData = response.data ?? [];
      _hasNextPage = response.pagination?.hasNextPage ?? false;

      if (reset) {
        state = AsyncValue.data(fetchedData);
      } else {
        state.whenData((oldList) {
          final updatedList = [...oldList, ...fetchedData];
          state = AsyncValue.data(updatedList);
        });
      }

      _currentPage++;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> loadMoreExperts() async {
    if (!_hasNextPage || _isLoading) return;
    await fetchExperts(reset: false);
  }

  Future<void> refreshExperts() async {
    await fetchExperts(reset: true);
  }

  bool get hasNextPage => _hasNextPage;
}

final expertPaginationProvider =
StateNotifierProvider<ExpertPaginationNotifier, AsyncValue<List<Data>>>(
      (ref) => ExpertPaginationNotifier(ref),
);
