import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartrip/features/DashBoard/indexes/Wishlist/repo/search_history_repo.dart';

class SearchState {
  final bool isLoading;
  final List<Place> results;
  final List<HistoryItem> history;
  final List<Place> recommended;

  const SearchState({
    this.isLoading = false,
    this.results = const [],
    this.history = const [],
    this.recommended = const [],
  });

  SearchState copyWith({
    bool? isLoading,
    List<Place>? results,
    List<HistoryItem>? history,
    List<Place>? recommended,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      results: results ?? this.results,
      history: history ?? this.history,
      recommended: recommended ?? this.recommended,
    );
  }
}

final searchProvider = StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  final repo = ref.read(searchRepoProvider);
  return SearchNotifier(repo);
});

class SearchNotifier extends StateNotifier<SearchState> {
  final SearchRepository _repo;
  SearchNotifier(this._repo) : super(const SearchState());


  Future<void> loadInitial() async {
    state = state.copyWith(isLoading: true);
    try {
      final hist = await _repo.getHistory();
      final rec = await _repo.getRecommended();
      state = state.copyWith(isLoading: false, history: hist, recommended: rec);
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> loadHistory() async {
    final hist = await _repo.getHistory();
    state = state.copyWith(history: hist);
  }

  Future<void> searchAndRecord(String query) async {
    state = state.copyWith(isLoading: true);
    try {
      await _repo.postSearch(query);
      final results = await _repo.searchPlaces(query);
      final hist = await _repo.getHistory();
      state = state.copyWith(isLoading: false, results: results, history: hist);
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> recordClick(Place place) async {
    state = state.copyWith(isLoading: true);
    try {
      await _repo.postClick(place);
      final hist = await _repo.getHistory();
      state = state.copyWith(isLoading: false, history: hist);
    } catch (_) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> removeHistory(String id) async {
    await _repo.deleteHistoryItem(id);
    state = state.copyWith(history: state.history.where((h) => h.id != id).toList());
  }
}
