import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartrip/Providers/bottomNavigationProvider.dart';
import 'package:smartrip/routes/app_router.dart';
import 'package:smartrip/utils/theme.dart';

class SchemeItem {
  final int id;
  final String place;
  final String quote;
  final String location;
  final String image;
  final String seasonPeriod;
  final String description;
  final List<String> chitsScheme;
  final List<String> budgetPlans;

  SchemeItem({
    required this.id,
    required this.place,
    required this.quote,
    required this.location,
    required this.image,
    required this.seasonPeriod,
    required this.description,
    required this.chitsScheme,
    required this.budgetPlans,
  });

  factory SchemeItem.fromMap(Map<String, dynamic> map) {
    return SchemeItem(
      id: map['id'],
      place: map['place'],
      quote: map['quote'],
      location: map['location'],
      image: map['image'],
      seasonPeriod: map['seasonPeriod'],
      description: map['description'],
      chitsScheme: List<String>.from(map['chitsScheme'] ?? []),
      budgetPlans: List<String>.from(map['budgetPlans'] ?? []),
    );
  }
}

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  List<SchemeItem> schemes = [];
  bool isLoading = true;

  ScrollController scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() {
        schemes = demoSchemes;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final expanded = 160.0;
    final isCollapsed = scroll.hasClients &&
        scroll.offset > (expanded - (kToolbarHeight + 56));

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        controller: scroll,
        slivers: [

          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            floating: false,
            elevation: 0,
            expandedHeight: expanded,
            collapsedHeight: kToolbarHeight,

            leading: IconButton(
              onPressed: () => ref.read(bottomNavProvider.notifier).state = 0,
              icon: Icon(Icons.arrow_back_ios_new, size: 22),
            ),

            title: AnimatedOpacity(
              duration: Duration(milliseconds: 200),
              opacity: isCollapsed ? 1 : 0,
              child: Container(
                height: 36,
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, size: 20, color: Colors.grey),
                    SizedBox(width: 8),
                    Text("Search places", style: TextStyle(fontSize: 13, color: Colors.grey)),
                  ],
                ),
              ),
            ),

            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text("Explore",
                        style: AppTheme.headingStyle.copyWith(fontSize: 26)),
                  ),
                ],
              ),
            ),

            bottom: isCollapsed
                ? null
                : PreferredSize(
              preferredSize: Size.fromHeight(56),
              child: Padding(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 8),
                child: Container(
                  height: 42,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: const [
                      Text("Search places...", style: TextStyle(color: Colors.grey)),
                      Spacer(),
                      Icon(Icons.search, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // CONTENT LIST
          isLoading
              ? SliverList(
            delegate: SliverChildBuilderDelegate(
                  (_, __) => Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: Container(
                  margin: EdgeInsets.all(12),
                  height: height * 0.25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              childCount: 6,
            ),
          )
              : SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                final item = schemes[index];
                return Container(
                  margin: EdgeInsets.all(12),
                  height: height * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage('assets/background/schemeback.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(width * 0.03),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            item.image,
                            width: width * 0.40,
                            height: height * 0.20,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: width * 0.04),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(item.place,
                                  style: AppTheme.headingStyle.copyWith(
                                      fontSize: width * 0.05)),
                              SizedBox(height: height * 0.01),
                              Text(item.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTheme.bodyTitle.copyWith(
                                      fontSize: width * 0.035,
                                      color: Colors.black87)),
                              SizedBox(height: height * 0.01),
                              ElevatedButton(
                                onPressed: () {

                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orangeAccent),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Explore'),
                                    SizedBox(width: 5),
                                    Icon(Icons.arrow_forward_rounded, size: 18),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              childCount: schemes.length,
            ),
          ),
        ],
      ),
    );
  }
}

// Dummy demo data (same as before)
final demoSchemes = <SchemeItem>[
  SchemeItem(
    id: 1,
    place: 'Goa',
    quote: '',
    location: 'Goa',
    image: 'assets/background/sche1.jpg',
    seasonPeriod: '',
    description: 'Goa is India’s beach paradise known for vibrant nightlife',
    chitsScheme: [],
    budgetPlans: [],
  ),
  SchemeItem(
    id: 2,
    place: 'Shimla',
    quote: '',
    location: 'Shimla',
    image: 'assets/background/sche2.jpg',
    seasonPeriod: '',
    description: 'Perfect for snow lovers and honeymooners',
    chitsScheme: [],
    budgetPlans: [],
  ),
  SchemeItem(
    id: 3,
    place: 'Kerala',
    quote: '',
    location: 'Kerala',
    image: 'assets/background/sche3.jpg',
    seasonPeriod: '',
    description: 'Green tea estates and backwaters',
    chitsScheme: [],
    budgetPlans: [],
  ),
];
