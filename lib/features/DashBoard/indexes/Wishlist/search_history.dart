import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartrip/features/DashBoard/indexes/Wishlist/notifier/search_history_notifier.dart';
import 'package:smartrip/features/DashBoard/indexes/Wishlist/repo/search_history_repo.dart';
import 'package:smartrip/utils/theme.dart';
import 'package:smartrip/routes/app_router.dart';
import 'package:smartrip/features/DashBoard/indexes/HomeScreen/CustomWidgets/Repos/homefetchRepo.dart';


class SearchHistoryScreen extends ConsumerStatefulWidget {
  const SearchHistoryScreen({super.key});
  @override
  ConsumerState<SearchHistoryScreen> createState() => _SearchHistoryScreenState();
}

class _SearchHistoryScreenState extends ConsumerState<SearchHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(searchProvider.notifier).loadInitial();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Where to ?', style: AppTheme.headingStyle),
      ),
      body: const SearchHistoryPanel(),
    );
  }
}

class SearchHistoryPanel extends ConsumerStatefulWidget {
  const SearchHistoryPanel({super.key, this.onClose});

  final VoidCallback? onClose;

  @override
  ConsumerState<SearchHistoryPanel> createState() => _SearchHistoryPanelState();
}

class _SearchHistoryPanelState extends ConsumerState<SearchHistoryPanel> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(searchProvider.notifier).loadInitial();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchProvider);

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.onClose != null) ...[
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: widget.onClose,
                  ),
                  Text('Where to go ?', style: AppTheme.headingStyle),
                ],
              ),
              const SizedBox(height: 4),
            ],

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _controller,
                onSubmitted: (value) {
                  if (value.trim().isEmpty) return;
                  ref.read(searchProvider.notifier).searchAndRecord(value.trim());
                },
                decoration: InputDecoration(
                  hintText: 'Search places...',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => _controller.clear(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            /// ---------- RECENT HISTORY ----------
            if (state.history.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Recent searches & clicks', style: AppTheme.bodyTitle),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: state.history.map((h) {
                    return Chip(
                      label: Text(h.label, overflow: TextOverflow.ellipsis,style: AppTheme.bodycontentStyle,),
                      avatar: Icon(
                        h.type == HistoryType.search ? Icons.search : Icons.place,
                        size: 16,
                      ),
                      onDeleted: () => ref.read(searchProvider.notifier).removeHistory(h.id),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 12),
            ],

            if (state.isLoading) const LinearProgressIndicator(),


            if (state.recommended.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text('Recommended for you', style: AppTheme.bodyTitle),
              ),
              const SizedBox(height: 8),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: state.recommended.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final p = state.recommended[index];
                  return _WishlistStyleTile(
                    title: p.name,
                    location: p.location ?? '',
                    imagePath: p.image ?? 'assets/banners/default.jpg',
                    onTap: () async {
                      await ref.read(searchProvider.notifier).recordClick(p);
                      if (context.mounted) {
                        final destination = Destination(
                          id: int.tryParse(p.id) ?? 0,
                          place: p.name,
                          quote: '',
                          location: p.location ?? '',
                          image: p.image ?? 'assets/banners/default.jpg',
                          description: 'Details loading from backend soon...',
                          chitsScheme: const [],
                          budgetPlans: const [],
                          travelRequirements: null,
                        );
                        context.pushRoute(
                          PlaceDetailRoute(
                            datalist: destination,
                            tag: 'rec_${p.id}',
                            imagePath: destination.image,
                            place: destination.place,
                            quote: destination.quote,
                            location: destination.location,
                          ),
                        );
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 12),
            ],

            /// ---------- SEARCH RESULTS ----------
            if (state.results.isNotEmpty)
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: state.results.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final p = state.results[index];
                  return _WishlistStyleTile(
                    title: p.name,
                    location: p.location ?? '',
                    imagePath: p.image ?? 'assets/banners/default.jpg',
                    onTap: () async {
                      await ref.read(searchProvider.notifier).recordClick(p);
                      if (context.mounted) {
                        final destination = Destination(
                          id: int.tryParse(p.id) ?? 0,
                          place: p.name,
                          quote: '',
                          location: p.location ?? '',
                          image: p.image ?? 'assets/banners/default.jpg',
                          description: 'Details loading from backend soon...',
                          chitsScheme: const [],
                          budgetPlans: const [],
                          travelRequirements: null,
                        );
                        context.pushRoute(
                          PlaceDetailRoute(
                            datalist: destination,
                            tag: 'search_${p.id}',
                            imagePath: destination.image,
                            place: destination.place,
                            quote: destination.quote,
                            location: destination.location,
                          ),
                        );
                      }
                    },
                  );
                },
              ),

            if (state.results.isEmpty)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    state.history.isEmpty
                        ? 'Start typing to search trips'
                        : 'No results yet. Try a different search.',
                    style: AppTheme.bodycontentStyle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );

  }
}

class _WishlistStyleTile extends StatelessWidget {
  const _WishlistStyleTile({
    required this.title,
    required this.location,
    required this.imagePath,
    required this.onTap,
  });

  final String title;
  final String location;
  final String imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagePath,
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.08,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.bodyTitle.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: AppTheme.bodycontentStyle.copyWith(color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  // mimic your "benefits/chits" row subtly (optional)
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '5+ benefits',
                          style: AppTheme.bodycontentStyle.copyWith(fontSize: 12, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.favorite, color: Colors.redAccent.shade200),
            ),
          ],
        ),
      ),
    );
  }
}

