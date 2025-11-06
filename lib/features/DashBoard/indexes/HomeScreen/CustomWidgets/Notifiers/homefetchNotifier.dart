import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartrip/features/DashBoard/indexes/HomeScreen/CustomWidgets/Repos/homefetchRepo.dart';

class HomeState {
  final bool isLoading;
  final String? error;
  final List<TabItem> tabs;

  HomeState({this.isLoading = false, this.error, this.tabs = const []});

  HomeState copyWith({bool? isLoading, String? error, List<TabItem>? tabs}) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      tabs: tabs ?? this.tabs,
    );
  }
}

/// AsyncNotifier that manages Tabs
class HomeNotifier extends AsyncNotifier<List<TabItem>> {
  late final HomeRepository _repository;

  @override
  Future<List<TabItem>> build() async {
    _repository = ref.read(homeRepositoryProvider);
    // Automatically fetch data on initialization
    return loadDestinations();
  }

  Future<List<TabItem>> loadDestinations({
    bool isInternational = true,
    String? searchQuery,
    String? country,
    int? minDuration,
    int? maxDuration,
    double? minPrice,
    double? maxPrice,
  }) async {
    try {
      final tabs = await _repository.fetchDestinations(
        isInternational: isInternational,
        searchQuery: searchQuery,
        country: country,
        minDuration: minDuration,
        maxDuration: maxDuration,
        minPrice: minPrice,
        maxPrice: maxPrice,
      );

      state = AsyncData(tabs); // update state
      return tabs;
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}

/// Repository Provider
final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository();
});

/// Provider
final homeProvider = AsyncNotifierProvider<HomeNotifier, List<TabItem>>(
  HomeNotifier.new,
);
