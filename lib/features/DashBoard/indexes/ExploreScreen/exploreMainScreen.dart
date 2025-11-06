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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'place': place,
      'quote': quote,
      'location': location,
      'image': image,
      'seasonPeriod': seasonPeriod,
      'description': description,
      'chitsScheme': chitsScheme,
      'budgetPlans': budgetPlans,
    };
  }
}

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _SchemesScreenState();
}

class _SchemesScreenState extends ConsumerState<ExploreScreen> {
  List<SchemeItem> schemes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 200), () {
      if (!mounted) return;

      setState(() {
        schemes = [
          SchemeItem(
            id: 1,
            place: 'Goa',
            quote: 'Where the sea meets your soul.',
            location: 'India – Goa Beaches',
            image: 'assets/background/sche1.jpg',
            seasonPeriod: 'Nov - Feb',
            description:
                'Goa is India’s beach paradise known for vibrant nightlife, Portuguese heritage, and scenic coastlines. Enjoy sunsets, water sports, seafood, and vibrant flea markets.',
            chitsScheme: [
              "🎯 Goal: ₹1,00,000",
              "🗓️ Duration: 6 or 12 months",
              "👥 Members: 3–5 people",
              "💰 ₹8,500/month (12 months)",
              "🔁 Payout for group or solo beach trips",
            ],
            budgetPlans: [
              "✈️ Flight to Goa (book 3 months in advance)",
              "🏖️ Stay in beach huts or guesthouses at Palolem or Baga",
              "🍛 Taste seafood at local shacks",
              "🏄‍♂️ Water sports: parasailing, banana boat, jet skiing",
              "🎉 Explore night markets & beach parties",
            ],
          ),
          SchemeItem(
            id: 2,
            place: 'Shimla',
            quote: 'Snow, peace, and pine air.',
            location: 'India – Himachal Pradesh',
            image: 'assets/background/sche2.jpg',
            seasonPeriod: 'Dec - Feb',
            description:
                'Shimla, the queen of hills, is perfect for winter getaways, snow-capped views, and cozy cottages. A must-visit for honeymooners and snow lovers.',
            chitsScheme: [
              "🎯 Goal: ₹96,000",
              "🗓️ Duration: 6 or 10 months",
              "👥 Members: 2–3 people",
              "💰 ₹9,600/month (10 months)",
              "🔁 Flexible payout for winter travel",
            ],
            budgetPlans: [
              "🚞 Kalka–Shimla Toy Train ride",
              "🏡 Stay in hillside cottages or budget hotels",
              "❄️ Snow activities at Kufri or Narkanda",
              "🥘 Enjoy Himachali cuisine like Madra, Siddu",
              "🛍️ Mall Road shopping & local crafts",
            ],
          ),
          SchemeItem(
            id: 3,
            place: 'Kerala',
            quote: 'God’s own country awaits.',
            location: 'India – Backwaters & Munnar',
            image: 'assets/background/sche3.jpg',
            seasonPeriod: 'Aug - Feb',
            description:
                'Kerala offers tranquil backwaters, green tea estates, and houseboat stays. Relax with Ayurveda treatments or explore wildlife sanctuaries.',
            chitsScheme: [
              "🎯 Goal: ₹1,20,000",
              "🗓️ Duration: 12 months",
              "👥 Members: 4 people",
              "💰 ₹10,000/month",
              "🔁 Use for family or couple vacations",
            ],
            budgetPlans: [
              "🚤 Houseboat in Alleppey or Kumarakom",
              "🏞️ Visit Munnar’s tea gardens",
              "🌴 Stay in eco resorts or homestays",
              "🧖‍♀️ Ayurvedic massages & therapies",
              "🥥 Taste authentic Kerala Sadhya",
            ],
          ),
          SchemeItem(
            id: 4,
            place: 'Rajasthan',
            quote: 'Live the royal desert tale.',
            location: 'India – Jaipur, Jodhpur, Jaisalmer',
            image: 'assets/background/sche4.jpg',
            seasonPeriod: 'Oct - Mar',
            description:
                'Rajasthan is all about forts, sand dunes, camel rides, and cultural royalty. Perfect for heritage lovers and festival seekers.',
            chitsScheme: [
              "🎯 Goal: ₹1,00,000",
              "🗓️ Duration: 6 or 12 months",
              "👥 Members: 3–5 people",
              "💰 ₹8,500/month",
              "🔁 Travel during Pushkar Fair or Desert Festival",
            ],
            budgetPlans: [
              "🏰 Fort tours: Amer, Mehrangarh, Jaisalmer",
              "🐪 Camel safari in Sam Sand Dunes",
              "🕌 Stay in havelis or desert camps",
              "🎶 Rajasthani folk music & dances",
              "🍛 Rajasthani Thali: Dal Baati, Ghewar",
            ],
          ),
          SchemeItem(
            id: 5,
            place: 'Kashmir',
            quote: 'If there’s paradise on Earth, it’s here.',
            location: 'India – Srinagar, Gulmarg, Pahalgam',
            image: 'assets/background/sche5.jpg',
            seasonPeriod: 'Dec - Mar',
            description:
                'Kashmir is a snowy dreamland with beautiful valleys, Shikara rides, and ski slopes. Ideal for romantic, scenic, and winter adventures.',
            chitsScheme: [
              "🎯 Goal: ₹1,10,000",
              "🗓️ Duration: 12 months",
              "👥 Members: 3–4 people",
              "💰 ₹9,200/month",
              "🔁 Flexible for family or couple travel",
            ],
            budgetPlans: [
              "🛶 Shikara ride in Dal Lake",
              "🏂 Skiing at Gulmarg",
              "🛏️ Stay in wooden houseboats",
              "🌨️ Snow activities & gondola rides",
              "🧣 Shop for pashmina & dry fruits",
            ],
          ),
        ];
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Navigator.pop(context);
            ref.read(bottomNavProvider.notifier).state = 0;
          },
          icon: Icon(Icons.arrow_circle_left_outlined, size: 35),
        ),
        scrolledUnderElevation: 0,
        title: Text('Explore', style: AppTheme.headingStyle),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body:
          isLoading
              ? ListView.builder(
                padding: EdgeInsets.all(width * 0.04),
                itemCount: 5,
                itemBuilder:
                    (_, __) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        margin: EdgeInsets.only(bottom: height * 0.02),
                        height: height * 0.25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(width * 0.05),
                        ),
                      ),
                    ),
              )
              : ListView.builder(
                itemCount: schemes.length,
                padding: EdgeInsets.all(width * 0.04),
                itemBuilder: (context, index) {
                  final item = schemes[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: height * 0.02),
                    height: height * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.05),
                      image: const DecorationImage(
                        image: AssetImage('assets/background/schemeback.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(width * 0.02),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  width * 0.05,
                                ),
                                child: Hero(
                                  tag: 'Explore_$index',
                                  child: Image.asset(
                                    item.image,
                                    width: width * 0.40,
                                    height: height * 0.20,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  height: height * 0.07,
                                  width: width * 0.40,
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(width * 0.05),
                                      bottomRight: Radius.circular(
                                        width * 0.05,
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item.place,
                                        style: AppTheme.bodyTitle.copyWith(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "(${item.chitsScheme.first.split(':')[1]})",
                                        style: AppTheme.bodyTitle.copyWith(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: width * 0.04),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.place,
                                  style: AppTheme.headingStyle.copyWith(
                                    fontSize: width * 0.05,
                                  ),
                                ),
                                SizedBox(height: height * 0.01),
                                Text(
                                  item.description,
                                  style: AppTheme.bodyTitle.copyWith(
                                    fontSize: width * 0.035,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: height * 0.015),
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle Explore click
                                    // context.pushRoute(
                                    //   PlaceDetailRoute(
                                    //     tag: 'Explore_$index',
                                    //     imagePath: item.image,
                                    //     place: item.place,
                                    //     quote: item.quote,
                                    //     location: item.location,
                                    //     datalist: item.toMap(),
                                    //   ),
                                    // );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orangeAccent,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.05,
                                      vertical: height * 0.0,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        width * 0.03,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Explore',
                                        style: AppTheme.buttonTextStyle
                                            .copyWith(fontSize: width * 0.04),
                                      ),
                                      SizedBox(width: width * 0.015),
                                      SvgPicture.asset(
                                        'assets/icons/route.svg',
                                        width: width * 0.07,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
