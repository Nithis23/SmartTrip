import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartrip/Providers/bottomNavigationProvider.dart';
import 'package:smartrip/features/DashBoard/indexes/HomeScreen/CustomWidgets/Repos/homefetchRepo.dart';
import 'package:smartrip/routes/app_router.dart';
import 'package:smartrip/utils/theme.dart';

class WishListScreen extends ConsumerStatefulWidget {
  const WishListScreen({super.key});

  @override
  ConsumerState<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends ConsumerState<WishListScreen> {
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
  @override
  Widget build(BuildContext context) {
    // wishlistItems.clear();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Navigator.pop(context);
            ref.read(bottomNavProvider.notifier).state = 0;
          },
          icon: Icon(Icons.arrow_circle_left_outlined, size: 35),
        ),
        scrolledUnderElevation: 0,
        title: Text('Wishlist', style: AppTheme.headingStyle),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child:
            wishlistItems.isEmpty
                ? Center(
                  child: Text('No Trips Added Yet!', style: AppTheme.bodyTitle),
                )
                : Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Theme(
                        data: Theme.of(
                          context,
                        ).copyWith(dividerColor: Colors.transparent),

                        child: ExpansionTile(
                          initiallyExpanded: true,
                          tilePadding: EdgeInsets.zero,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Most Popular Destinations',
                                style: AppTheme.headingStyle.copyWith(
                                  fontSize: 22.sp,
                                ),
                              ),
                              GestureDetector(
                                onTap:
                                    () =>
                                        ref
                                            .read(bottomNavProvider.notifier)
                                            .state = 0,
                                child: Text(
                                  'Manage',
                                  style: AppTheme.bodycontentStyle.copyWith(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          children: [
                            const SizedBox(height: 10),
                            ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: wishlistItems.length,
                              itemBuilder: (context, index) {
                                final item = wishlistItems[index];
                                return GestureDetector(
                                  onTap: () {
                                    // context.pushRoute(
                                    //   PlaceDetailRoute(
                                    //     datalist: Destination(id: id, place: place, quote: quote, location: location, image: image, description: description, chitsScheme: chitsScheme, budgetPlans: budgetPlans),
                                    //     tag: 'wishlist_${item['id']}',
                                    //     imagePath: item['image'],
                                    //     place: item['place'],
                                    //     quote: item['quote'],
                                    //     location: item['location'],
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.only(bottom: 8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 0.5,
                                        color: Colors.grey.shade300,
                                      ),
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
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          child: Image.asset(
                                            item['image'],
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.2,
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.08,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                item['place'],
                                                style: AppTheme.bodyTitle
                                                    .copyWith(
                                                      color:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.color,
                                                    ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    size: 16,
                                                    color: Colors.grey,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Expanded(
                                                    child: Text(
                                                      item['location'],
                                                      style: AppTheme
                                                          .bodycontentStyle
                                                          .copyWith(
                                                            color: Colors.grey,
                                                          ),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      '${item['chitsScheme'].first}, ${item['chitsScheme'].last}',
                                                      style: AppTheme
                                                          .bodycontentStyle
                                                          .copyWith(
                                                            color: Colors.grey,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            fontSize: 12,
                                                          ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      '5+ benefits',
                                                      style: AppTheme
                                                          .bodycontentStyle
                                                          .copyWith(
                                                            fontSize: 12,
                                                            color: Colors.grey,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                            'assets/icons/like.svg',
                                            width: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                      Divider(),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Seasonal Trip',
                            style: AppTheme.headingStyle.copyWith(
                              fontSize: 22.sp,
                            ),
                          ),
                          GestureDetector(
                            onTap:
                                () =>
                                    ref.read(bottomNavProvider.notifier).state =
                                        0,
                            child: Text(
                              'Manage',
                              style: AppTheme.bodycontentStyle.copyWith(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.07,
                        ),
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/like.svg',
                              width: 45,
                              colorFilter: ColorFilter.mode(
                                Colors.redAccent.shade100,
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'No Seasonal Trips added',
                              style: AppTheme.bodyTitle.copyWith(
                                fontSize: 16.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 150),
                    ],
                  ),
                ),
      ),
    );
  }
}
