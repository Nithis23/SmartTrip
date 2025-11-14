import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartrip/Providers/bottomNavigationProvider.dart';
import 'package:smartrip/features/DashBoard/indexes/HomeScreen/CustomWidgets/Repos/homefetchRepo.dart';
import 'package:smartrip/routes/app_router.dart';
import 'package:smartrip/utils/theme.dart';
import 'package:smartrip/features/DashBoard/indexes/Wishlist/search_history.dart';

class WishListScreen extends ConsumerStatefulWidget {
  const WishListScreen({super.key});

  @override
  ConsumerState<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends ConsumerState<WishListScreen> {
  bool _showSearch = false;

  final List<Map<String, dynamic>> wishlistItems = [
    {
      "id": 1,
      "place": "Paris – Love in the City of Lights",
      'quote': 'Love in the city of night',
      "location": "Eiffel Tower, Paris",
      'image': 'assets/banners/paris.jpg',
      "description":
      "The Eiffel Tower is a wrought-iron lattice tower located in Paris, France, and was completed in 1889 for the World's Fair. Standing at 330 meters tall, it was the tallest man-made structure in the world until 1930. Today, it is one of the most iconic landmarks and a symbol of France.",
      "chitsScheme": [
        "🎯 Goal: ₹2,00,000 (₹1,00,000 per person)",
        "🗓️ Duration: 10 months",
        "👥 Members: 2 people (1 + 1)",
        "💰 Monthly Contribution: ₹20,000 (₹10,000 / person)",
        "🔁 Payout Option: Take the money after 10 months OR alternate who takes first.",
      ],
      "budgetPlans": [
        "✈️ Discounted round-trip airfare (book 6–8 months in advance)",
        "🏨 Budget hotel stay/hostels for 5 days",
        "🗼 Eiffel Tower 2nd-floor or summit entry",
        "🚋 Local transport via metro/tram",
        "🍞 Daily meals on a budget",
        "📸 DIY sightseeing (Louvre from outside, Seine walk, Notre-Dame)",
      ],
    },
    {
      "id": 2,
      "place": "Harajuku & Takeshita Street",
      'quote': 'Takeshita Street',
      "location": "Shibuya, Tokyo",
      'image': 'assets/banners/tokyo.jpg',
      "description":
      "Harajuku is the fashion capital of Tokyo, known for its youth culture, colorful outfits, and street style. Takeshita Street is a popular pedestrian area filled with trendy shops, crepe stands, and J-pop culture.",
      "chitsScheme": [
        "🎯 Goal: ₹1,50,000",
        "🗓️ Duration: 8 months",
        "👥 Members: 3 people",
        "💰 Monthly Contribution: ₹18,750 per person",
        "🔁 Flexible payout for early travelers",
      ],
      "budgetPlans": [
        "✈️ Budget airline ticket (book 4–6 months early)",
        "🏨 Capsule hotel in Harajuku",
        "🛍️ Shopping & cosplay experience on Takeshita Street",
        "🚄 JR Pass for local metro",
        "🍡 Street food like crepes, takoyaki",
        "🎌 Visit Meiji Shrine & Yoyogi Park",
      ],
    },
    {
      "id": 3,
      "place": "Burj Khalifa – Touch the Sky",
      'quote': '',
      "location": "Downtown Dubai, UAE",
      'image': 'assets/banners/burjkhalifa.jpg',
      "description":
      "Burj Khalifa is the tallest structure and building in the world, located in Dubai. It features luxurious observation decks, dining experiences, and breathtaking views of the desert skyline.",
      "chitsScheme": [
        "🎯 Goal: ₹2,50,000",
        "🗓️ Duration: 12 months",
        "👥 Members: 5 people",
        "💰 Monthly Contribution: ₹5,000 per person",
        "🔁 Early payout for business class upgrades",
      ],
      "budgetPlans": [
        "✈️ Round-trip economy ticket (book in off-season)",
        "🏨 Budget hotel near Downtown Dubai",
        "🌆 Burj Khalifa Level 124 & 125 entry",
        "🚕 Ride-sharing apps or Metro Card",
        "🍽️ Eat at food courts or Al Mallah",
        "🛍️ Dubai Mall window shopping & fountain show",
      ],
    },
    {
      "id": 4,
      "place": "Nusa Penida Island – Nature’s Gem",
      'quote': '',
      "location": "Bali, Indonesia",
      'image': 'assets/banners/bali.jpg',
      "description":
      "Nusa Penida is a breathtaking island southeast of Bali, known for its rugged coastline, crystal-clear waters, and dramatic cliffs like Kelingking Beach. Perfect for nature lovers and adventurers.",
      "chitsScheme": [
        "🎯 Goal: ₹1,20,000",
        "🗓️ Duration: 6 months",
        "👥 Members: 4 people",
        "💰 Monthly Contribution: ₹5,000 per person",
        "🔁 Group travel payout every 3 months",
      ],
      "budgetPlans": [
        "✈️ Round-trip flight to Bali + ferry to Nusa Penida",
        "🏝️ Budget beach huts or hostels",
        "📸 Explore Kelingking, Angel’s Billabong, Crystal Bay",
        "🚲 Rent a scooter for local transport",
        "🍜 Eat at warungs (local food stalls)",
        "🌅 Sunset views and beach picnics",
      ],
    },
  ];


  final List<Map<String, dynamic>> completedTrips = [];

  @override
  Widget build(BuildContext context) {
    final kb = MediaQuery.of(context).viewInsets.bottom;
    final double overlayBottom = _showSearch ? (kb > 0 ? kb : 80.0) : -MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // if overlay is open, close it first
            if (_showSearch) {
              FocusManager.instance.primaryFocus?.unfocus();
              setState(() => _showSearch = false);
              return;
            }
            ref.read(bottomNavProvider.notifier).state = 0;
          },
          icon: const Icon(Icons.arrow_circle_left_outlined, size: 35),
        ),
        scrolledUnderElevation: 0,
        title: Text('Search & History', style: AppTheme.headingStyle),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // === original scrollable wishlist content (TILES COMMENTED OUT) ===
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // ===========================
                  // Original tiles are commented out to hide them while keeping code available:
                  // ===========================
                  /*
                  ...wishlistItems.map((item) {
                    return GestureDetector(
                      onTap: () {
                        final destination = Destination(
                          id: item['id'],
                          place: item['place'],
                          quote: item['quote'],
                          location: item['location'],
                          image: item['image'],
                          description: item['description'],
                          chitsScheme: List<String>.from(item['chitsScheme']),
                          budgetPlans: List<String>.from(item['budgetPlans']),
                          travelRequirements: null,
                        );
                        context.pushRoute(
                          PlaceDetailRoute(
                            datalist: destination,
                            tag: 'wishlist_${item['id']}',
                            imagePath: item['image'],
                            place: item['place'],
                            quote: item['quote'],
                            location: item['location'],
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
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
                                item['image'],
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
                                    item['place'],
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
                                          item['location'],
                                          style: AppTheme.bodycontentStyle.copyWith(color: Colors.grey),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.favorite, color: Colors.redAccent),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  */

                  // A spacer so the centered card appears vertically comfortable
                  const SizedBox(height: 24),

                  // ----------------------------
                  // Centered Start Trip card (moved from FAB to content center)
                  // ----------------------------
                  Center(
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [

                          const Icon(Icons.favorite, color: Colors.pinkAccent, size: 36),
                          const SizedBox(height: 8),
                          Text('Plan your way with Trips...', style: AppTheme.bodyTitle.copyWith(fontSize: 18)),
                          const SizedBox(height: 12),
                          Text(
                            'Build a trip with your saves and get custom recommendations, collaborate with friends, and organise your trip ideas.',
                            textAlign: TextAlign.center,
                            style: AppTheme.bodycontentStyle,
                          ),
                          const SizedBox(height: 18),

                          // Create a trip (keeps visual but action kept minimal)
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                // keep existing behavior - open overlay as start trip action
                                FocusManager.instance.primaryFocus?.unfocus();
                                setState(() => _showSearch = true);
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                side: BorderSide(color: Colors.grey.shade300),
                              ),
                              child: Text('Create a trip', style: AppTheme.bodyTitle.copyWith(color: Colors.black)),
                            ),
                          ),
                          const SizedBox(height: 12),

                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Divider(height: 1),
                  const SizedBox(height: 12),
                  Text('Completed Trips', style: AppTheme.bodyTitle),
                  const SizedBox(height: 8),


                  SizedBox(
                    height: 300,
                    child: SingleChildScrollView(
                      child: completedTrips.isEmpty
                          ? Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Text(
                          "You haven't completed a trip yet !, Kindly click Start trip and know our services",
                          style: AppTheme.bodycontentStyle,
                          textAlign: TextAlign.center,
                        ),
                      )
                          : Column(
                        children: completedTrips.map((c) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Colors.grey.shade300),
                              ),
                              tileColor: Colors.white,
                              leading: const Icon(Icons.check_circle, color: Colors.green),
                              title: Text(c['title'] ?? ''),
                              subtitle: Text(c['subtitle'] ?? ''),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),


                  const SizedBox(height: 150),
                ],
              ),
            ),
          ),


          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            left: 0,
            right: 0,
            top: _showSearch ? 0 : MediaQuery.of(context).size.height,
            bottom: overlayBottom,
            child: IgnorePointer(
              ignoring: !_showSearch,
              child:Material(
                elevation: 0,
                shadowColor: Colors.transparent,
                color: Colors.white,
                child: SafeArea(
                  bottom: false,
                  child: SearchHistoryPanel(
                    onClose: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() => _showSearch = false);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      // Remove floating button (we moved Start Trip into content center)
      floatingActionButton: null,
    );
  }
}
