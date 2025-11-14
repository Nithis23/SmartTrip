
import 'dart:io';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartrip/Common/AlertBox/alert.dart';
import 'package:smartrip/Common/Notifications/notification_screen.dart';
import 'package:smartrip/LocalStorage/loginStorage.dart';
import 'package:smartrip/features/DashBoard/dashboardMainScreen.dart';
import 'package:smartrip/features/DashBoard/indexes/HomeScreen/CustomWidgets/Notifiers/homefetchNotifier.dart';
import 'package:smartrip/features/DashBoard/indexes/HomeScreen/CustomWidgets/customShimmer.dart';
import 'package:smartrip/features/DashBoard/indexes/HomeScreen/CustomWidgets/mostPopularList.dart';
import 'package:smartrip/routes/app_router.dart';
import 'package:smartrip/utils/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';

final tabIndexProvider = StateProvider<int>((ref) => 0);

class HomeHeaderContent extends ConsumerStatefulWidget {
  final double statusBarHeight;
  final String userName;
  final String locationText;
  final VoidCallback onSearchTap;
  final String logoPath;

  const HomeHeaderContent({
    super.key,
    required this.statusBarHeight,
    required this.userName,
    required this.locationText,
    required this.onSearchTap,
    this.logoPath = 'assets/logo/smartLogo.png',
  });

  @override
  ConsumerState<HomeHeaderContent> createState() => _HomeHeaderContentState();
}

class _HomeHeaderContentState extends ConsumerState<HomeHeaderContent>
    with AutomaticKeepAliveClientMixin {
  late ScrollController scroll;
  File? _profileImage;
  static const String _imagePathKey = 'profile_image_path';

  void _onScroll() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    scroll = ref.read(scrollControllerProvider);
    scroll.addListener(_onScroll);
    _loadProfileImage();
  }

  @override
  void dispose() {
    scroll.removeListener(_onScroll);
    super.dispose();
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString(_imagePathKey);
    if (imagePath != null && File(imagePath).existsSync()) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final scroll1 = ref.watch(scrollControllerProvider);
    final homeAsync = ref.watch(homeProvider);

    return homeAsync.when(
      loading: () => const HomeShimmerLoader(),
      error: (err, _) => Scaffold(body: Center(child: Text("Error: $err"))),
      data: (tabs) {
        final tabIndex = ref.watch(tabIndexProvider);
        final double expanded = MediaQuery.of(context).size.height * .25;
        final bool isCollapsed = scroll1.hasClients &&
            scroll1.offset > (expanded - (kToolbarHeight + 56));

        return DefaultTabController(
          length: tabs.length,
          initialIndex: tabIndex,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: NestedScrollView(
              controller: scroll1,
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                final bool collapsed = isCollapsed || innerBoxIsScrolled;
                return [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: false,
                    backgroundColor: Colors.white,
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    expandedHeight: expanded,
                    collapsedHeight: kToolbarHeight,
                    toolbarHeight: kToolbarHeight,


                    leadingWidth: 160,
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: GestureDetector(
                        onTap: () {
                          context.router.push(PassportKycRoute());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on, size: 16, color: Color(0xFFF99431)),
                              const SizedBox(width: 4),


                              Expanded(
                                child: Text(
                                  widget.locationText,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTheme.bodycontentStyle.copyWith(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),



                    title: const SizedBox.shrink(),



                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white38,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text('Hi, ${widget.userName}', style: AppTheme.bodyTitle.copyWith(fontSize: 14)),
                        ),
                      ),


                      IconButton(
                        icon: const Icon(Icons.notifications_none, color: Colors.black),
                        onPressed: () {

                          try {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationScreen()));
                          } catch (e) {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationScreen()));
                          }
                        },
                      ),


                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: CircleAvatar(
                          radius: 18,
                          backgroundImage: _profileImage != null ? FileImage(_profileImage!) : const AssetImage('assets/icons/profile.jpg') as ImageProvider,
                        ),
                      ),
                    ],


                    flexibleSpace: FlexibleSpaceBar(
                      background: CarouselSlider(
                        items: const [
                          "assets/banners/burjkhalifa.jpg",
                          "assets/banners/tokyo.jpg",
                          "assets/banners/bali.jpg",
                        ].map((path) {
                          return Image.asset(
                            path,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          );
                        }).toList(),
                        options: CarouselOptions(
                          autoPlay: true,
                          viewportFraction: 1.0,
                          height: double.infinity,
                        ),
                      ),
                    ),



                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(collapsed ? 56 : 112),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!collapsed)
                            Container(
                            color: Colors.white.withOpacity(0.75),
                            child: TabBar(
                              tabAlignment: TabAlignment.start,
                              isScrollable: true,
                              unselectedLabelColor: Colors.black87,
                              labelColor: const Color.fromRGBO(249, 148, 48, 1),
                              indicatorColor: const Color.fromRGBO(249, 148, 48, 1),
                              labelStyle: AppTheme.bodyTitle.copyWith(fontWeight: FontWeight.bold),
                              tabs: tabs.map((t) => Tab(text: t.label)).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ];
              },

              body: TabBarView(
                children: tabs.map((tab) {
                  return ListView(
                    padding: EdgeInsets.zero,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      ...tab.destinationGroups.entries.expand(
                            (entry) => entry.value
                            .where((v) => v.travelRequirements?.documents != null)
                            .expand(
                              (v) => v.travelRequirements!.documents.map(
                                (doc) => Text(
                              " $doc",
                              style: AppTheme.bodyTitle,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                      Text(
                        ' ${tab.label.split(" ")[0]} with Us !!!',
                        style: AppTheme.headingStyle.copyWith(),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),

                      Container(
                        margin: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tab.banner.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(tab.banner.subtitle),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  tab.banner.cta['label'],
                                  style: AppTheme.bodyTitle.copyWith(color: Colors.blueAccent),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          tab.label,
                          style: AppTheme.headingStyle.copyWith(
                            fontSize: 22.sp,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      ...tab.destinationGroups.entries.map((entry) {
                        final groupName = entry.key.isNotEmpty ? entry.key[0].toUpperCase() + entry.key.substring(1) : '';
                        final destinations = entry.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: Colors.deepOrange,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    groupName,
                                    style: AppTheme.headingStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.1,
                                    ),
                                  ),
                                  const Spacer(),
                                  Icon(
                                    Icons.star_rounded,
                                    color: Colors.amber.shade600,
                                    size: 22,
                                  ),
                                ],
                              ),
                            ),
                            MostPopularListiview(
                              dataList: destinations,
                              parentHeight: MediaQuery.of(context).size.height * 0.25,
                              itemWidthRatio: 0.55,
                              itemHeightRatio: 0.90,
                            ),
                          ],
                        );
                      }).toList(),

                      const SizedBox(height: 16),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
