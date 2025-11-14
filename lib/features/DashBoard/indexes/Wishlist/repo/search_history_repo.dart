import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Place {
  final String id;
  final String name;
  final String? location;
  final String? category;
  final String? subcategory;
  final String? image;

  Place({
    required this.id,
    required this.name,
    this.location,
    this.category,
    this.subcategory,
    this.image,
  });
}

enum HistoryType { search, click }

class HistoryItem {
  final String id;
  final String label;
  final HistoryType type;
  final DateTime createdAt;

  HistoryItem({
    required this.id,
    required this.label,
    required this.type,
    required this.createdAt,
  });
}

class _LocalStore {
  static final List<Place> recommended = <Place>[
    Place(id: '1', name: 'Paris – Love in the City of Lights', location: 'Eiffel Tower, Paris', category: 'International', subcategory: 'Europe', image: 'assets/banners/paris.jpg'),
    Place(id: '2', name: 'Harajuku & Takeshita Street', location: 'Shibuya, Tokyo', category: 'International', subcategory: 'Asia', image: 'assets/banners/tokyo.jpg'),
    Place(id: '3', name: 'Burj Khalifa – Touch the Sky', location: 'Downtown Dubai, UAE', category: 'International', subcategory: 'Middle East', image: 'assets/banners/burjkhalifa.jpg'),
    Place(id: '4', name: 'Nusa Penida Island – Nature’s Gem', location: 'Bali, Indonesia', category: 'International', subcategory: 'Asia', image: 'assets/banners/bali.jpg'),
  ];

  static final List<Place> catalog = <Place>[
    ...recommended,
    Place(id: '5', name: 'Agra Fort', location: 'Agra, India', category: 'Domestic', subcategory: 'North India', image: 'assets/banners/default.jpg'),
    Place(id: '6', name: 'Taj Mahal', location: 'Agra, India', category: 'Domestic', subcategory: 'North India', image: 'assets/banners/default.jpg'),
    Place(id: '7', name: 'Hampi Ruins', location: 'Karnataka, India', category: 'Domestic', subcategory: 'South India', image: 'assets/banners/default.jpg'),
    Place(id: '8', name: 'Great Wall – Mutianyu', location: 'Beijing, China', category: 'International', subcategory: 'Asia', image: 'assets/banners/default.jpg'),
  ];

  static final List<HistoryItem> history = <HistoryItem>[];

  static String _newId() => '${DateTime.now().microsecondsSinceEpoch}_${Random().nextInt(9999)}';
}

final searchRepoProvider = Provider<SearchRepository>((ref) {
  return SearchRepository.local();
});

class SearchRepository {
  SearchRepository.local();

  Future<List<Place>> getRecommended() async {
    return List<Place>.from(_LocalStore.recommended);
  }

  Future<List<HistoryItem>> getHistory() async {
    final list = List<HistoryItem>.from(_LocalStore.history)
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

  Future<void> postSearch(String query) async {
    final q = query.trim();
    if (q.isEmpty) return;
    _LocalStore.history.add(
      HistoryItem(id: _LocalStore._newId(), label: q, type: HistoryType.search, createdAt: DateTime.now()),
    );
  }

  Future<void> postClick(Place place) async {
    _LocalStore.history.add(
      HistoryItem(id: _LocalStore._newId(), label: place.name, type: HistoryType.click, createdAt: DateTime.now()),
    );
  }

  Future<List<Place>> searchPlaces(String query) async {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return <Place>[];
    final all = _LocalStore.catalog;
    return all.where((p) {
      final name = p.name.toLowerCase();
      final loc = (p.location ?? '').toLowerCase();
      final cat = (p.category ?? '').toLowerCase();
      final sub = (p.subcategory ?? '').toLowerCase();
      return name.contains(q) || loc.contains(q) || cat.contains(q) || sub.contains(q);
    }).toList();
  }

  Future<void> deleteHistoryItem(String id) async {
    _LocalStore.history.removeWhere((h) => h.id == id);
  }
}
