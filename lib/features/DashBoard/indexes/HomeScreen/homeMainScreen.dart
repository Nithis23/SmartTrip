import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartrip/features/DashBoard/indexes/HomeScreen/CustomWidgets/mainHomeContents.dart'
    show HomeHeaderContent;
import 'package:smartrip/features/DashBoard/indexes/HomeScreen/CustomWidgets/stackSearchContent.dart';

final toggleSearch = StateProvider.autoDispose<bool>((ref) => false);

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // ref.invalidate(toggleSearch);
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    var toggle = ref.watch(toggleSearch);
    var toggleaction = ref.read(toggleSearch.notifier);

    return Stack(
      fit: StackFit.expand,
      children: [
        // Main content
        HomeHeaderContent(
          statusBarHeight: statusBarHeight,
          userName: 'Mohan',
          locationText: 'Chennai, India',
          onSearchTap: () => toggleaction.state = true,
        ),

        // Search overlay
        if (toggle)
          SearchOverlayWidget(
            allItems: List.generate(100, (i) => 'Result $i'),

            controller: _searchController,
            statusBarHeight: statusBarHeight,
            onClose: () => toggleaction.state = false,
            onResultTap: (index) {
              // handle result tap (optional)
              debugPrint("Tapped result $index");
            },
          ),
      ],
    );
  }
}
