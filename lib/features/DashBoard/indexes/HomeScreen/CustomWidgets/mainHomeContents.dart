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
import 'package:smartrip/LocalStorage/loginStorage.dart';
import 'package:smartrip/features/DashBoard/dashboardMainScreen.dart';
import 'package:smartrip/features/DashBoard/indexes/HomeScreen/CustomWidgets/Notifiers/homefetchNotifier.dart';
import 'package:smartrip/features/DashBoard/indexes/HomeScreen/CustomWidgets/customShimmer.dart';
import 'package:smartrip/features/DashBoard/indexes/HomeScreen/CustomWidgets/mostPopularList.dart';
import 'package:smartrip/routes/app_router.dart';
import 'package:smartrip/utils/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
// tab_index_provider.dart

/// Holds the currently selected tab index
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
  @override
  void initState() {
    super.initState();
    scroll = ref.read(scrollControllerProvider); // Use global provider
    _loadProfileImage();
    if (scroll.hasClients && scroll.offset != 0) {
      scroll.animateTo(
        0.0,
        duration: Duration(milliseconds: 600),
        curve: Curves.easeIn,
      );
    }
  }

  File? _profileImage;
  // final ImagePicker _picker = ImagePicker();
  static const String _imagePathKey = 'profile_image_path';

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString(_imagePathKey);
    if (imagePath != null && File(imagePath).existsSync()) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  // final List<Map<String, dynamic>> destinations = [
  //   {
  //     "id": 1,
  //     "place": "Paris – Love in the City of Lights",
  //     'quote': 'Love in the city of night',
  //     "location": "Eiffel Tower, Paris",
  //     'image': 'assets/banners/paris.jpg',
  //     "description":
  //         "The Eiffel Tower is a wrought-iron lattice tower located in Paris, France, and was completed in 1889 for the World's Fair. Standing at 330 meters tall, it was the tallest man-made structure in the world until 1930. Today, it is one of the most iconic landmarks and a symbol of France.",
  //     "chitsScheme": [
  //       "🎯 Goal: ₹2,00,000 (₹1,00,000 per person)",
  //       "🗓️ Duration: 10 months",
  //       "👥 Members: 2 people (1 + 1)",
  //       "💰 Monthly Contribution: ₹20,000 (₹10,000 / person)",
  //       "🔁 Payout Option: Take the money after 10 months OR alternate who takes first.",
  //     ],
  //     "budgetPlans": [
  //       "✈️ Discounted round-trip airfare (book 6–8 months in advance)",
  //       "🏨 Budget hotel stay/hostels for 5 days",
  //       "🗼 Eiffel Tower 2nd-floor or summit entry",
  //       "🚋 Local transport via metro/tram",
  //       "🍞 Daily meals on a budget",
  //       "📸 DIY sightseeing (Louvre from outside, Seine walk, Notre-Dame)",
  //     ],
  //   },
  //   {
  //     "id": 2,
  //     "place": "Harajuku & Takeshita Street",
  //     'quote': 'Takeshita Street',
  //     "location": "Shibuya, Tokyo",
  //     'image': 'assets/banners/tokyo.jpg',
  //     "description":
  //         "Harajuku is the fashion capital of Tokyo, known for its youth culture, colorful outfits, and street style. Takeshita Street is a popular pedestrian area filled with trendy shops, crepe stands, and J-pop culture.",
  //     "chitsScheme": [
  //       "🎯 Goal: ₹1,50,000",
  //       "🗓️ Duration: 8 months",
  //       "👥 Members: 3 people",
  //       "💰 Monthly Contribution: ₹18,750 per person",
  //       "🔁 Flexible payout for early travelers",
  //     ],
  //     "budgetPlans": [
  //       "✈️ Budget airline ticket (book 4–6 months early)",
  //       "🏨 Capsule hotel in Harajuku",
  //       "🛍️ Shopping & cosplay experience on Takeshita Street",
  //       "🚄 JR Pass for local metro",
  //       "🍡 Street food like crepes, takoyaki",
  //       "🎌 Visit Meiji Shrine & Yoyogi Park",
  //     ],
  //   },
  //   {
  //     "id": 3,
  //     "place": "Burj Khalifa – Touch the Sky",
  //     'quote': '',
  //     "location": "Downtown Dubai, UAE",
  //     'image': 'assets/banners/burjkhalifa.jpg',
  //     "description":
  //         "Burj Khalifa is the tallest structure and building in the world, located in Dubai. It features luxurious observation decks, dining experiences, and breathtaking views of the desert skyline.",
  //     "chitsScheme": [
  //       "🎯 Goal: ₹2,50,000",
  //       "🗓️ Duration: 12 months",
  //       "👥 Members: 5 people",
  //       "💰 Monthly Contribution: ₹5,000 per person",
  //       "🔁 Early payout for business class upgrades",
  //     ],
  //     "budgetPlans": [
  //       "✈️ Round-trip economy ticket (book in off-season)",
  //       "🏨 Budget hotel near Downtown Dubai",
  //       "🌆 Burj Khalifa Level 124 & 125 entry",
  //       "🚕 Ride-sharing apps or Metro Card",
  //       "🍽️ Eat at food courts or Al Mallah",
  //       "🛍️ Dubai Mall window shopping & fountain show",
  //     ],
  //   },
  //   {
  //     "id": 4,
  //     "place": "Nusa Penida Island – Nature’s Gem",
  //     'quote': '',
  //     "location": "Bali, Indonesia",
  //     'image': 'assets/banners/bali.jpg',
  //     "description":
  //         "Nusa Penida is a breathtaking island southeast of Bali, known for its rugged coastline, crystal-clear waters, and dramatic cliffs like Kelingking Beach. Perfect for nature lovers and adventurers.",
  //     "chitsScheme": [
  //       "🎯 Goal: ₹1,20,000",
  //       "🗓️ Duration: 6 months",
  //       "👥 Members: 4 people",
  //       "💰 Monthly Contribution: ₹5,000 per person",
  //       "🔁 Group travel payout every 3 months",
  //     ],
  //     "budgetPlans": [
  //       "✈️ Round-trip flight to Bali + ferry to Nusa Penida",
  //       "🏝️ Budget beach huts or hostels",
  //       "📸 Explore Kelingking, Angel’s Billabong, Crystal Bay",
  //       "🚲 Rent a scooter for local transport",
  //       "🍜 Eat at warungs (local food stalls)",
  //       "🌅 Sunset views and beach picnics",
  //     ],
  //   },
  // ];

  // final List<Map<String, dynamic>> seasonalList = [
  //   {
  //     "id": 1,
  //     "place": "Switzerland – Alpine Winter Escape",
  //     'quote': 'A scenic paradise nestled in the Alps.',
  //     "location": "Europe – Swiss Alps",
  //     "image": "assets/banners/sea1.jpg",
  //     "seasonPeriod": "Dec - Feb",
  //     "description":
  //         "Switzerland in winter is a wonderland of snow-capped peaks, scenic train rides, and cozy alpine villages. Visit iconic spots like Zermatt, Lucerne, and the Matterhorn. Perfect for skiing, snowboarding, or just relaxing with a view.",
  //     "chitsScheme": [
  //       "🎯 Goal: ₹1,80,000",
  //       "🗓️ Duration: 6 or 10 months",
  //       "👥 Members: 3 people",
  //       "💰 Options: ₹5,000/month (6 months)",
  //       "🔁 Flexible payouts for group travel",
  //     ],
  //     "budgetPlans": [
  //       "✈️ Round-trip flights to Zurich or Geneva (book 4–6 months ahead)",
  //       "🚄 Scenic rail pass for Swiss trains (Glacier Express, Bernina Express)",
  //       "🏔️ Stay in mountain lodges or budget hotels in Lucerne/Zermatt",
  //       "🧀 Enjoy cheese fondue & hot chocolate",
  //       "🎿 Optional ski pass for selected resorts",
  //       "📸 Visit lakes, Alps, and Christmas markets",
  //     ],
  //   },
  //   {
  //     "id": 2,
  //     "place": "Cherry Blossom Japan – Spring in Bloom",
  //     'quote': "Witness nature's poetry in pink.",
  //     "location": "Asia – Tokyo, Kyoto, Osaka",
  //     "image": "assets/banners/sea2.jpg",
  //     "seasonPeriod": "Mar - Apr",
  //     "description":
  //         "Spring in Japan is a magical experience as cherry blossoms bloom across parks and temples. Enjoy Hanami picnics, traditional culture, and the vibrant streets of Tokyo and Kyoto.",
  //     "chitsScheme": [
  //       "🎯 Goal: ₹2,40,000",
  //       "🗓️ Duration: 6 or 12 months",
  //       "👥 Members: 2–4 people",
  //       "💰 Options: ₹4,000/month (6 months)",
  //       "🔁 Payout based on travel schedule or season timing",
  //     ],
  //     "budgetPlans": [
  //       "✈️ Flights to Tokyo (book 5–7 months early)",
  //       "🏨 Stay in capsule hotels or guesthouses near Ueno, Shinjuku",
  //       "🌸 Visit Ueno Park, Maruyama Park, and Philosopher's Path for Hanami",
  //       "🚅 Get JR Pass for intercity travel (Tokyo ↔ Kyoto ↔ Osaka)",
  //       "🍱 Try sakura mochi, bento, ramen, and street food",
  //       "⛩️ Explore temples, shrines, and local spring festivals",
  //     ],
  //   },
  // ];

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final scroll1 = ref.watch(scrollControllerProvider); // Same controller
    final homeAsync = ref.watch(homeProvider);

    return homeAsync.when(
      loading: () => const HomeShimmerLoader(),

      error: (err, _) => Scaffold(body: Center(child: Text("Error: $err"))),
      data: (tabs) {
        return Consumer(
          builder: (context, ref, _) {
            final tabIndex = ref.watch(tabIndexProvider);

            return DefaultTabController(
              length: tabs.length,
              initialIndex: tabIndex,
              child: Builder(
                builder: (context) {
                  final tabController = DefaultTabController.of(context);

                  tabController.addListener(() {
                    if (!tabController.indexIsChanging) {
                      ref.read(tabIndexProvider.notifier).state =
                          tabController.index;
                    }
                  });

                  return Scaffold(
                    backgroundColor: Colors.white,
                    body: CustomScrollView(
                      controller: scroll1,
                      slivers: [
                        // 🔹 SliverAppBar with FlexibleSpaceBar
                        SliverAppBar(
                          automaticallyImplyLeading: false,
                          pinned: true,
                          floating: false,
                          expandedHeight:
                              MediaQuery.of(context).size.height * .25,
                          backgroundColor: Colors.white,
                          elevation: 0,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Stack(
                              fit: StackFit.expand,
                              children: [
                                CarouselSlider(
                                  items:
                                      [
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
                                    height:
                                        double
                                            .infinity, // fills FlexibleSpaceBar
                                  ),
                                ),
                                // Container(
                                //   color: Colors.black.withOpacity(
                                //     0.3,
                                //   ), // 👈 overlay for text visibility
                                // ),
                                Positioned(
                                  top: MediaQuery.of(context).padding.top,
                                  right: 0,
                                  left: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      // vertical: 10,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Location container
                                        GestureDetector(
                                          onTap: () {
                                            context.router.push(
                                              PassportKycRoute(),
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white38,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.location_on,
                                                  size: 18,
                                                  color: Color.fromRGBO(
                                                    249,
                                                    148,
                                                    49,
                                                    1,
                                                  ),
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  widget.locationText,
                                                  style:
                                                      AppTheme.bodycontentStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        // Hi, User + avatar
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white38,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                'Hi, ${widget.userName}',
                                                style: AppTheme.bodyTitle,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            PopupMenuButton<String>(
                                              color: Colors.white,
                                              tooltip: 'Menu',
                                              offset: const Offset(-60, 50),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              onSelected: (value) {
                                                if (value == 'profile') {
                                                  context.pushRoute(
                                                    ProfileRoute(),
                                                  );
                                                } else if (value == 'logout') {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (_) => CustomAlertBox(
                                                          title: "Logout",
                                                          message:
                                                              "Are you sure you want to logout?",
                                                          confirmText: "Logout",
                                                          onConfirm: () async {
                                                            Navigator.of(
                                                              context,
                                                            ).pop();
                                                            await logoutUser(
                                                              context,
                                                            );
                                                            final prefs =
                                                                await SharedPreferences.getInstance();
                                                            await prefs.remove(
                                                              'profile_image_path',
                                                            );
                                                          },
                                                        ),
                                                  );
                                                }
                                              },
                                              itemBuilder:
                                                  (_) => [
                                                    PopupMenuItem(
                                                      value: 'profile',
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.person,
                                                            size: 20,
                                                            color:
                                                                Colors.black87,
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            'Profile',
                                                            style:
                                                                AppTheme
                                                                    .bodycontentStyle,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      value: 'logout',
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.logout,
                                                            size: 20,
                                                            color:
                                                                Colors.black87,
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            'Logout',
                                                            style:
                                                                AppTheme
                                                                    .bodycontentStyle,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                              child: CircleAvatar(
                                                radius: 22,
                                                backgroundImage:
                                                    _profileImage != null
                                                        ? FileImage(
                                                          _profileImage!,
                                                        )
                                                        : const AssetImage(
                                                              'assets/icons/profile.jpg',
                                                            )
                                                            as ImageProvider,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          bottom:
                              tabs.isNotEmpty
                                  ? PreferredSize(
                                    preferredSize: const Size.fromHeight(48),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                            0.02, // 2% of screen width
                                      ),

                                      child: Builder(
                                        builder: (context) {
                                          final tabController =
                                              DefaultTabController.of(context);

                                          // 👀 Sync TabController with Provider
                                          tabController.addListener(() {
                                            if (!tabController
                                                .indexIsChanging) {
                                              ref
                                                  .read(
                                                    tabIndexProvider.notifier,
                                                  )
                                                  .state = tabController.index;
                                            }
                                          });

                                          return ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                ),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                sigmaX: 2,
                                                sigmaY: 2,
                                              ), // Frosted glass
                                              child: Container(
                                                color: Colors.white.withOpacity(
                                                  0.75,
                                                ), // Semi-opaque
                                                child: // Search bar
                                                    Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top: 15,
                                                        bottom: 15.0,
                                                      ),
                                                  child: GestureDetector(
                                                    onTap: widget.onSearchTap,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical: 12,
                                                          ),
                                                      margin:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[200],
                                                        border: Border.all(
                                                          color:
                                                              Colors
                                                                  .grey
                                                                  .shade400,
                                                          width: .8,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              20,
                                                            ),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                            "Search Your Destinations...",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                          ),
                                                          SvgPicture.asset(
                                                            'assets/icons/search.svg',
                                                            colorFilter:
                                                                const ColorFilter.mode(
                                                                  Color.fromRGBO(
                                                                    249,
                                                                    148,
                                                                    49,
                                                                    1,
                                                                  ),
                                                                  BlendMode
                                                                      .srcIn,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                  : null,

                          scrolledUnderElevation: 0,
                        ),

                        // 🔹 TabBarView content
                        SliverFillRemaining(
                          child: Column(
                            children: [
                              const SizedBox(height: 15),
                              tabs.isNotEmpty
                                  ? PreferredSize(
                                    preferredSize: const Size.fromHeight(48),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 6,
                                          sigmaY: 6,
                                        ), // Frosted glass
                                        child: Container(
                                          color: Colors.white.withOpacity(
                                            0.75,
                                          ), // Semi-opaque
                                          child: TabBar(
                                            tabAlignment: TabAlignment.start,
                                            isScrollable: true,
                                            unselectedLabelColor:
                                                Colors.black87,
                                            labelColor: const Color.fromRGBO(
                                              249,
                                              148,
                                              48,
                                              1,
                                            ),
                                            indicatorColor:
                                                const Color.fromRGBO(
                                                  249,
                                                  148,
                                                  48,
                                                  1,
                                                ),
                                            labelStyle: AppTheme.bodyTitle
                                                .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                            tabs:
                                                tabs
                                                    .map(
                                                      (t) => Tab(text: t.label),
                                                    )
                                                    .toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  : SizedBox.shrink(),
                              Expanded(
                                child: TabBarView(
                                  children:
                                      tabs.map((tab) {
                                        return SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ...tab.destinationGroups.entries.expand(
                                                (entry) => entry.value
                                                    .where(
                                                      (v) =>
                                                          v
                                                              .travelRequirements
                                                              ?.documents !=
                                                          null,
                                                    )
                                                    .expand(
                                                      (v) => v
                                                          .travelRequirements!
                                                          .documents
                                                          .map(
                                                            (doc) => Text(
                                                              " $doc",
                                                              style:
                                                                  AppTheme
                                                                      .bodyTitle,
                                                            ),
                                                          ),
                                                    ),
                                              ),

                                              const SizedBox(height: 20),
                                              Text(
                                                ' ${tab.label.split(" ")[0]} with Us !!!',
                                                style: AppTheme.headingStyle
                                                    .copyWith(
                                                      // fontSize: 25.sp,
                                                    ),
                                                textAlign: TextAlign.center,
                                              ),

                                              const SizedBox(height: 20),

                                              // Banner
                                              Container(
                                                margin: const EdgeInsets.all(
                                                  12,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: Colors.grey.shade300,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color:
                                                          Colors.grey.shade200,
                                                      blurRadius: 4,
                                                      offset: const Offset(
                                                        0,
                                                        2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                    12,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        tab.banner.title,
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(tab.banner.subtitle),
                                                      TextButton(
                                                        onPressed: () {},
                                                        child: Text(
                                                          tab
                                                              .banner
                                                              .cta['label'],
                                                          style: AppTheme
                                                              .bodyTitle
                                                              .copyWith(
                                                                color:
                                                                    Colors
                                                                        .blueAccent,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              // Section title
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 12.0,
                                                    ),
                                                child: Text(
                                                  tab.label,
                                                  style: AppTheme.headingStyle
                                                      .copyWith(
                                                        fontSize: 22.sp,
                                                      ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),

                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children:
                                                    tab.destinationGroups.entries.map((
                                                      entry,
                                                    ) {
                                                      final groupName =
                                                          entry.key.isNotEmpty
                                                              ? entry.key[0]
                                                                      .toUpperCase() +
                                                                  entry.key
                                                                      .substring(
                                                                        1,
                                                                      )
                                                              : '';

                                                      final destinations =
                                                          entry.value;

                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets.symmetric(
                                                                  horizontal:
                                                                      12.0,
                                                                  vertical: 8.0,
                                                                ),
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  width: 6,
                                                                  height: 24,
                                                                  decoration: BoxDecoration(
                                                                    color:
                                                                        Colors
                                                                            .deepOrange, // 👈 accent color
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                          4,
                                                                        ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text(
                                                                  groupName,
                                                                  style: AppTheme
                                                                      .headingStyle
                                                                      .copyWith(
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        letterSpacing:
                                                                            1.1,
                                                                      ),
                                                                ),
                                                                const Spacer(),
                                                                Icon(
                                                                  Icons
                                                                      .star_rounded,
                                                                  color:
                                                                      Colors
                                                                          .amber
                                                                          .shade600,
                                                                  size: 22,
                                                                ), // 👈 subtle icon flair
                                                              ],
                                                            ),
                                                          ),
                                                          MostPopularListiview(
                                                            dataList:
                                                                destinations,
                                                            parentHeight:
                                                                MediaQuery.of(
                                                                  context,
                                                                ).size.height *
                                                                0.25,
                                                            itemWidthRatio:
                                                                0.55,
                                                            itemHeightRatio:
                                                                0.90,
                                                          ),
                                                        ],
                                                      );
                                                    }).toList(),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );

    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(top: widget.statusBarHeight),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            // Top bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Location Container
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 18,
                          color: Color.fromRGBO(249, 148, 49, 1),
                        ),
                        const SizedBox(width: 6),
                        Text(widget.locationText, style: AppTheme.bodyTitle),
                      ],
                    ),
                  ),
                ),

                // Greeting + Image
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Text('Hi, ${widget.userName}', style: AppTheme.bodyTitle),
                      const SizedBox(width: 10),
                      PopupMenuButton<String>(
                        color: Colors.white,
                        tooltip: 'Menu',
                        offset: const Offset(
                          -60,
                          50,
                        ), // Adjust X to move menu left
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        onSelected: (value) {
                          if (value == 'schemes') {
                            // Navigate to My Schemes
                          } else if (value == 'logout') {
                            // Handle logout
                            // logoutUser(context);
                            showDialog(
                              context: context,
                              builder:
                                  (context) => CustomAlertBox(
                                    title: "Logout",
                                    message: "Are you sure you want to logout?",
                                    confirmText: "Logout",
                                    onConfirm: () async {
                                      Navigator.of(context).pop();
                                      await logoutUser(context);
                                      final prefs =
                                          await SharedPreferences.getInstance();

                                      await prefs.remove('profile_image_path');
                                      // Perform logout logic
                                    },
                                  ),
                            );
                          } else if (value == 'profile') {
                            // Navigate to Profile
                            context.pushRoute(ProfileRoute());
                          }
                        },
                        itemBuilder:
                            (BuildContext context) => [
                              PopupMenuItem<String>(
                                value: 'profile',
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      size: 20,
                                      color: Colors.black87,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Profile',
                                      style: AppTheme.bodycontentStyle,
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem<String>(
                                value: 'logout',
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.logout,
                                      size: 20,
                                      color: Colors.black87,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Logout',
                                      style: AppTheme.bodycontentStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                        child: Material(
                          elevation: 2,
                          shape: const CircleBorder(),
                          shadowColor: Colors.grey.withOpacity(0.5),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 6.9,
                            height: MediaQuery.of(context).size.width / 6.9,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 50.r,
                              backgroundImage:
                                  _profileImage != null
                                      ? FileImage(_profileImage!)
                                      : const AssetImage(
                                            'assets/icons/profile.jpg',
                                          )
                                          as ImageProvider,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Content below search
            Expanded(
              child: SingleChildScrollView(
                controller: scroll1,
                child: Column(
                  children: [
                    // MostPopularListiview(
                    //   dataList: destinations,
                    //   parentHeight: MediaQuery.of(context).size.height * 0.25,
                    //   itemWidthRatio: 0.55,
                    //   itemHeightRatio: 0.90,
                    // ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Seasonal Trip',
                            style: AppTheme.headingStyle.copyWith(
                              fontSize: 22.sp,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            'View All',
                            style: AppTheme.bodycontentStyle.copyWith(
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // SeasonalListiview(
                    //   dataList: seasonalList,
                    //   parentHeight: 180,
                    //   itemWidthRatio: 0.45,
                    //   itemHeightRatio: 0.9,
                    // ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Featured Journey',
                            style: AppTheme.headingStyle.copyWith(
                              fontSize: 22.sp,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Text(
                            'View All',
                            style: AppTheme.bodycontentStyle.copyWith(
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // FeaturedList(
                    //   items: [
                    //     FeaturedItem(
                    //       id: 5,
                    //       place: 'Taj Mahal',
                    //       quote: 'A timeless symbol of love',
                    //       location: 'Agra, Uttar Pradesh',
                    //       image: 'assets/banners/fea1.jpg',
                    //       description:
                    //           'The Taj Mahal is a stunning white marble mausoleum built by Mughal emperor Shah Jahan in memory of his wife Mumtaz Mahal. It is one of the Seven Wonders of the World and a UNESCO World Heritage Site.',
                    //       chitsScheme: [
                    //         "🎯 Goal: ₹60,000",
                    //         "🗓️ Duration: 6 months",
                    //         "👥 Members: 2 people",
                    //         "💰 Monthly Contribution: ₹5,000 per person",
                    //         "🔁 Equal payout or lucky draw",
                    //       ],
                    //       budgetPlans: [
                    //         "🚆 Train to Agra from Delhi",
                    //         "🏨 Budget hotel stay (2 nights)",
                    //         "🎟️ Taj Mahal entry ticket",
                    //         "🚗 Local sightseeing to Agra Fort, Mehtab Bagh",
                    //         "🍽️ Street food like petha & chaat",
                    //       ],
                    //     ),
                    //     FeaturedItem(
                    //       id: 6,
                    //       place: 'Hampi',
                    //       quote: 'Ruins that whisper history',
                    //       location: 'Karnataka, India',
                    //       image: 'assets/banners/fea2.jpg',
                    //       description:
                    //           'Hampi, a UNESCO World Heritage Site, is famous for its ancient temples, boulder-strewn landscapes, and ruins of the Vijayanagara Empire. A haven for backpackers and history lovers alike.',
                    //       chitsScheme: [
                    //         "🎯 Goal: ₹45,000",
                    //         "🗓️ Duration: 5 months",
                    //         "👥 Members: 3 people",
                    //         "💰 Monthly Contribution: ₹3,000 per person",
                    //         "🔁 Rotating monthly payout",
                    //       ],
                    //       budgetPlans: [
                    //         "🚌 Bus or train to Hospet + auto to Hampi",
                    //         "🏕️ Guesthouse or homestay in Hampi Bazaar",
                    //         "🏛️ Visit Virupaksha Temple, Vittala Temple, Elephant Stables",
                    //         "🚲 Bicycle rental for exploring ruins",
                    //         "🥗 Local South Indian thali meals",
                    //       ],
                    //     ),
                    //     FeaturedItem(
                    //       id: 7,
                    //       place: 'Khajuraho Temple',
                    //       quote: 'Erotic art in divine stone',
                    //       location: 'Madhya Pradesh, India',
                    //       image: 'assets/banners/fea3.jpg',
                    //       description:
                    //           'Khajuraho is known for its stunning temples with intricate sculptures that celebrate life, love, and spirituality. A masterpiece of Chandela dynasty architecture and heritage.',
                    //       chitsScheme: [
                    //         "🎯 Goal: ₹50,000",
                    //         "🗓️ Duration: 4 months",
                    //         "👥 Members: 2 people",
                    //         "💰 Monthly Contribution: ₹6,250 per person",
                    //         "🔁 Final payout after completion",
                    //       ],
                    //       budgetPlans: [
                    //         "✈️ Train or flight to Khajuraho",
                    //         "🏨 Budget lodge or heritage stay",
                    //         "⛩️ Entry to Western Group of Temples",
                    //         "🛵 Local sightseeing via rented scooter",
                    //         "🍛 Traditional Bundelkhand cuisine",
                    //       ],
                    //     ),

                    //     //additional
                    //     FeaturedItem(
                    //       id: 8,
                    //       place: 'Taj Mahal',
                    //       quote: 'A timeless symbol of love',
                    //       location: 'Agra, Uttar Pradesh',
                    //       image: 'assets/banners/fea1.jpg',
                    //       description:
                    //           'The Taj Mahal is a stunning white marble mausoleum built by Mughal emperor Shah Jahan in memory of his wife Mumtaz Mahal. It is one of the Seven Wonders of the World and a UNESCO World Heritage Site.',
                    //       chitsScheme: [
                    //         "🎯 Goal: ₹60,000",
                    //         "🗓️ Duration: 6 months",
                    //         "👥 Members: 2 people",
                    //         "💰 Monthly Contribution: ₹5,000 per person",
                    //         "🔁 Equal payout or lucky draw",
                    //       ],
                    //       budgetPlans: [
                    //         "🚆 Train to Agra from Delhi",
                    //         "🏨 Budget hotel stay (2 nights)",
                    //         "🎟️ Taj Mahal entry ticket",
                    //         "🚗 Local sightseeing to Agra Fort, Mehtab Bagh",
                    //         "🍽️ Street food like petha & chaat",
                    //       ],
                    //     ),
                    //     FeaturedItem(
                    //       id: 9,
                    //       place: 'Hampi',
                    //       quote: 'Ruins that whisper history',
                    //       location: 'Karnataka, India',
                    //       image: 'assets/banners/fea2.jpg',
                    //       description:
                    //           'Hampi, a UNESCO World Heritage Site, is famous for its ancient temples, boulder-strewn landscapes, and ruins of the Vijayanagara Empire. A haven for backpackers and history lovers alike.',
                    //       chitsScheme: [
                    //         "🎯 Goal: ₹45,000",
                    //         "🗓️ Duration: 5 months",
                    //         "👥 Members: 3 people",
                    //         "💰 Monthly Contribution: ₹3,000 per person",
                    //         "🔁 Rotating monthly payout",
                    //       ],
                    //       budgetPlans: [
                    //         "🚌 Bus or train to Hospet + auto to Hampi",
                    //         "🏕️ Guesthouse or homestay in Hampi Bazaar",
                    //         "🏛️ Visit Virupaksha Temple, Vittala Temple, Elephant Stables",
                    //         "🚲 Bicycle rental for exploring ruins",
                    //         "🥗 Local South Indian thali meals",
                    //       ],
                    //     ),
                    //     FeaturedItem(
                    //       id: 10,
                    //       place: 'Khajuraho Temple',
                    //       quote: 'Erotic art in divine stone',
                    //       location: 'Madhya Pradesh, India',
                    //       image: 'assets/banners/fea3.jpg',
                    //       description:
                    //           'Khajuraho is known for its stunning temples with intricate sculptures that celebrate life, love, and spirituality. A masterpiece of Chandela dynasty architecture and heritage.',
                    //       chitsScheme: [
                    //         "🎯 Goal: ₹50,000",
                    //         "🗓️ Duration: 4 months",
                    //         "👥 Members: 2 people",
                    //         "💰 Monthly Contribution: ₹6,250 per person",
                    //         "🔁 Final payout after completion",
                    //       ],
                    //       budgetPlans: [
                    //         "✈️ Train or flight to Khajuraho",
                    //         "🏨 Budget lodge or heritage stay",
                    //         "⛩️ Entry to Western Group of Temples",
                    //         "🛵 Local sightseeing via rented scooter",
                    //         "🍛 Traditional Bundelkhand cuisine",
                    //       ],
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
