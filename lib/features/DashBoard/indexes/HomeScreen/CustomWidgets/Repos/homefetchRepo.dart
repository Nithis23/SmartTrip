import 'package:dio/dio.dart';

class TravelRequirements {
  final bool passportRequired;
  final bool visaRequired;
  final List<String> documents;
  final String? minBalanceProof;

  TravelRequirements({
    required this.passportRequired,
    required this.visaRequired,
    required this.documents,
    this.minBalanceProof,
  });

  factory TravelRequirements.fromJson(Map<String, dynamic> json) {
    return TravelRequirements(
      passportRequired: json['passportRequired'] ?? false,
      visaRequired: json['visaRequired'] ?? false,
      documents: List<String>.from(json['documents'] ?? []),
      minBalanceProof: json['minBalanceProof'],
    );
  }
}

class Destination {
  final int id;
  final String place;
  final String quote;
  final String location;
  final String image;
  final String description;
  final List<String> chitsScheme;
  final List<String> budgetPlans;
  final TravelRequirements? travelRequirements; // nullable ✅

  Destination({
    required this.id,
    required this.place,
    required this.quote,
    required this.location,
    required this.image,
    required this.description,
    required this.chitsScheme,
    required this.budgetPlans,
    this.travelRequirements, // nullable ✅
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'],
      place: json['place'],
      quote: json['quote'] ?? '',
      location: json['location'],
      image: json['image'],
      description: json['description'],
      chitsScheme: List<String>.from(json['chitsScheme'] ?? []),
      budgetPlans: List<String>.from(json['budgetPlans'] ?? []),
      travelRequirements:
          json['travelRequirements'] != null
              ? TravelRequirements.fromJson(json['travelRequirements'])
              : null, // safe ✅
    );
  }
}

class TabItem {
  final String id;
  final String label;
  final BannerData banner;

  /// Destinations can be flat list or grouped by categories
  final Map<String, List<Destination>> destinationGroups;

  TabItem({
    required this.id,
    required this.label,
    required this.banner,
    required this.destinationGroups,
  });

  factory TabItem.fromJson(Map<String, dynamic> json) {
    final rawDestinations = json['destinations'];
    final Map<String, List<Destination>> parsedDestinations = {};

    if (rawDestinations is List) {
      // Case 1: flat list
      parsedDestinations['default'] =
          rawDestinations.map((e) => Destination.fromJson(e)).toList();
    } else if (rawDestinations is Map) {
      // Case 2: grouped lists
      rawDestinations.forEach((key, value) {
        parsedDestinations[key] =
            (value as List).map((e) => Destination.fromJson(e)).toList();
      });
    }

    return TabItem(
      id: json['id'],
      label: json['label'],
      banner: BannerData.fromJson(json['banner']),
      destinationGroups: parsedDestinations,
    );
  }
}

class BannerData {
  final String title;
  final String subtitle;
  final String imageUrl;
  final Map<String, dynamic> cta;

  BannerData({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.cta,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) {
    return BannerData(
      title: json['title'],
      subtitle: json['subtitle'],
      imageUrl: json['imageUrl'],
      cta: json['cta'],
    );
  }
}

class HomeRepository {
  /// Fetch trips (International / Domestic) with optional filters
  Future<List<TabItem>> fetchDestinations({
    bool isInternational = true,
    String? searchQuery,
    String? country,
    int? minDuration,
    int? maxDuration,
    double? minPrice,
    double? maxPrice,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    try {
      final response = {
        "status": "success",
        "timestamp": "2025-08-30T10:30:00Z",
        "meta": {
          "apiVersion": "1.0",
          "currency": "INR",
          "defaultTab": "international",
          "cacheable": true,
          "cacheExpiryMinutes": 15,
        },
        "userContext": {
          "id": "U12345",
          "name": "John Doe",
          "email": "john@example.com",
          "phone": "+91-9876543210",
          "profileImage": "https://cdn.app.com/profiles/john.png",
          "passport": {
            "number": "P1234567",
            "expiryDate": "2030-05-15",
            "issuedCountry": "IN",
          },
          "preferences": {
            "preferredCurrency": "INR",
            "preferredLanguage": "en",
            "travelStyle": ["Adventure", "Luxury"],
          },
          "stats": {
            "loyaltyPoints": 120,
            "completedBookings": 8,
            "upcomingTrips": 2,
          },
          "recentBookings": [
            {
              "packageId": "PKG1001",
              "title": "Thailand Delight",
              "status": "Completed",
              "date": "2025-06-01",
            },
            {
              "packageId": "PKG2001",
              "title": "Goa Beach Retreat",
              "status": "Upcoming",
              "date": "2025-09-15",
            },
          ],
        },
        "filters": {
          "duration": [
            {"id": "short", "label": "1-3 Days", "min": 1, "max": 3},
            {"id": "medium", "label": "4-7 Days", "min": 4, "max": 7},
            {"id": "long", "label": "8-14 Days", "min": 8, "max": 14},
            {"id": "extended", "label": "15+ Days", "min": 15},
          ],
          "priceRange": [
            {"id": "budget", "label": "Below 20,000", "min": 0, "max": 20000},
            {"id": "mid", "label": "20,000-50,000", "min": 20000, "max": 50000},
            {
              "id": "premium",
              "label": "50,000-1,00,000",
              "min": 50000,
              "max": 100000,
            },
            {"id": "luxury", "label": "1,00,000+", "min": 100000},
          ],
          "locations": [
            {"code": "IN", "label": "India", "type": "domestic"},
            {"code": "TH", "label": "Thailand", "type": "international"},
            {"code": "AE", "label": "Dubai", "type": "international"},
            {"code": "US", "label": "United States", "type": "international"},
          ],
          "themes": [
            {"id": "adventure", "label": "Adventure"},
            {"id": "family", "label": "Family"},
            {"id": "luxury", "label": "Luxury"},
            {"id": "honeymoon", "label": "Honeymoon"},
            {"id": "spiritual", "label": "Spiritual"},
          ],
          "sortOptions": [
            {"id": "price_low_high", "label": "Price: Low to High"},
            {"id": "price_high_low", "label": "Price: High to Low"},
            {"id": "rating_high", "label": "Top Rated"},
            {"id": "popular", "label": "Most Popular"},
            {"id": "new", "label": "Newest First"},
          ],
        },
        "tabs": [
          {
            "id": "international",
            "isPassportVerified": false,
            "label": "International Trips",
            "banner": {
              "title": "Explore the World",
              "subtitle": "Top international destinations curated for you",
              "imageUrl": "https://cdn.app.com/banners/international.png",
              "cta": {"label": "View All", "action": "/international/all"},
            },
            "destinations": {
              "mostPopular": [
                {
                  "id": 1,
                  "place": "Paris – Love in the City of Lights",
                  'quote': 'Love in the city of night',
                  "location": "Eiffel Tower, Paris",
                  'image': 'assets/banners/paris.jpg',
                  "description":
                      "The Eiffel Tower is a wrought-iron lattice tower located in Paris, France, and was completed in 1889 for the World's Fair. Standing at 330 meters tall, it was the tallest man-made structure in the world until 1930. Today, it is one of the most iconic landmarks and a symbol of France.",
                  "travelRequirements": {
                    "passportRequired": true,
                    "visaRequired": true,
                    "documents": [
                      "Valid Passport (6+ months validity)",
                      "Schengen Visa",
                      "Travel Insurance",
                      "Return Flight Ticket",
                      "Proof of Accommodation",
                    ],
                    "minBalanceProof": "₹1,50,000 (recommended bank statement)",
                  },
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
                  "id": 3,
                  "place": "Burj Khalifa – Touch the Sky",
                  'quote': '',
                  "location": "Downtown Dubai, UAE",
                  'image': 'assets/banners/burjkhalifa.jpg',
                  "travelRequirements": null,
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
              ],
              "seasonal": [
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
              ],
              "journey": [
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
              ],
            },
          },
          {
            "id": "domestic",
            "label": "Domestic Trips",
            "banner": {
              "title": "Incredible India",
              "subtitle": "Discover hidden gems within India",
              "imageUrl": "https://cdn.app.com/banners/domestic.png",
              "cta": {"label": "View All", "action": "/domestic/all"},
            },
            "destinations": {
              "mostPopular": [
                {
                  "id": 1,
                  "place": "Switzerland – Alpine Winter Escape",
                  'quote': 'A scenic paradise nestled in the Alps.',
                  "location": "Europe – Swiss Alps",
                  "image": "assets/banners/sea1.jpg",
                  "seasonPeriod": "Dec - Feb",
                  "description":
                      "Switzerland in winter is a wonderland of snow-capped peaks, scenic train rides, and cozy alpine villages. Visit iconic spots like Zermatt, Lucerne, and the Matterhorn. Perfect for skiing, snowboarding, or just relaxing with a view.",
                  "chitsScheme": [
                    "🎯 Goal: ₹1,80,000",
                    "🗓️ Duration: 6 or 10 months",
                    "👥 Members: 3 people",
                    "💰 Options: ₹5,000/month (6 months)",
                    "🔁 Flexible payouts for group travel",
                  ],
                  "budgetPlans": [
                    "✈️ Round-trip flights to Zurich or Geneva (book 4–6 months ahead)",
                    "🚄 Scenic rail pass for Swiss trains (Glacier Express, Bernina Express)",
                    "🏔️ Stay in mountain lodges or budget hotels in Lucerne/Zermatt",
                    "🧀 Enjoy cheese fondue & hot chocolate",
                    "🎿 Optional ski pass for selected resorts",
                    "📸 Visit lakes, Alps, and Christmas markets",
                  ],
                },
                {
                  "id": 2,
                  "place": "Cherry Blossom Japan – Spring in Bloom",
                  'quote': "Witness nature's poetry in pink.",
                  "location": "Asia – Tokyo, Kyoto, Osaka",
                  "image": "assets/banners/sea2.jpg",
                  "seasonPeriod": "Mar - Apr",
                  "description":
                      "Spring in Japan is a magical experience as cherry blossoms bloom across parks and temples. Enjoy Hanami picnics, traditional culture, and the vibrant streets of Tokyo and Kyoto.",
                  "chitsScheme": [
                    "🎯 Goal: ₹2,40,000",
                    "🗓️ Duration: 6 or 12 months",
                    "👥 Members: 2–4 people",
                    "💰 Options: ₹4,000/month (6 months)",
                    "🔁 Payout based on travel schedule or season timing",
                  ],
                  "budgetPlans": [
                    "✈️ Flights to Tokyo (book 5–7 months early)",
                    "🏨 Stay in capsule hotels or guesthouses near Ueno, Shinjuku",
                    "🌸 Visit Ueno Park, Maruyama Park, and Philosopher's Path for Hanami",
                    "🚅 Get JR Pass for intercity travel (Tokyo ↔ Kyoto ↔ Osaka)",
                    "🍱 Try sakura mochi, bento, ramen, and street food",
                    "⛩️ Explore temples, shrines, and local spring festivals",
                  ],
                },
              ],
            },
          },
          {
            "id": "domestic",
            "label": "Urban Trips",
            "banner": {
              "title": "Incredible India",
              "subtitle": "Discover hidden gems within India",
              "imageUrl": "https://cdn.app.com/banners/domestic.png",
              "cta": {"label": "View All", "action": "/domestic/all"},
            },
            "destinations": {
              "mostPopular": [
                {
                  "id": 1,
                  "place": "Switzerland – Alpine Winter Escape",
                  'quote': 'A scenic paradise nestled in the Alps.',
                  "location": "Europe – Swiss Alps",
                  "image": "assets/banners/sea1.jpg",
                  "seasonPeriod": "Dec - Feb",
                  "description":
                      "Switzerland in winter is a wonderland of snow-capped peaks, scenic train rides, and cozy alpine villages. Visit iconic spots like Zermatt, Lucerne, and the Matterhorn. Perfect for skiing, snowboarding, or just relaxing with a view.",
                  "chitsScheme": [
                    "🎯 Goal: ₹1,80,000",
                    "🗓️ Duration: 6 or 10 months",
                    "👥 Members: 3 people",
                    "💰 Options: ₹5,000/month (6 months)",
                    "🔁 Flexible payouts for group travel",
                  ],
                  "budgetPlans": [
                    "✈️ Round-trip flights to Zurich or Geneva (book 4–6 months ahead)",
                    "🚄 Scenic rail pass for Swiss trains (Glacier Express, Bernina Express)",
                    "🏔️ Stay in mountain lodges or budget hotels in Lucerne/Zermatt",
                    "🧀 Enjoy cheese fondue & hot chocolate",
                    "🎿 Optional ski pass for selected resorts",
                    "📸 Visit lakes, Alps, and Christmas markets",
                  ],
                },
                {
                  "id": 2,
                  "place": "Cherry Blossom Japan – Spring in Bloom",
                  'quote': "Witness nature's poetry in pink.",
                  "location": "Asia – Tokyo, Kyoto, Osaka",
                  "image": "assets/banners/sea2.jpg",
                  "seasonPeriod": "Mar - Apr",
                  "description":
                      "Spring in Japan is a magical experience as cherry blossoms bloom across parks and temples. Enjoy Hanami picnics, traditional culture, and the vibrant streets of Tokyo and Kyoto.",
                  "chitsScheme": [
                    "🎯 Goal: ₹2,40,000",
                    "🗓️ Duration: 6 or 12 months",
                    "👥 Members: 2–4 people",
                    "💰 Options: ₹4,000/month (6 months)",
                    "🔁 Payout based on travel schedule or season timing",
                  ],
                  "budgetPlans": [
                    "✈️ Flights to Tokyo (book 5–7 months early)",
                    "🏨 Stay in capsule hotels or guesthouses near Ueno, Shinjuku",
                    "🌸 Visit Ueno Park, Maruyama Park, and Philosopher's Path for Hanami",
                    "🚅 Get JR Pass for intercity travel (Tokyo ↔ Kyoto ↔ Osaka)",
                    "🍱 Try sakura mochi, bento, ramen, and street food",
                    "⛩️ Explore temples, shrines, and local spring festivals",
                  ],
                },
              ],
            },
          },
        ],
        "notifications": [
          {
            "id": "NTF001",
            "type": "payment_reminder",
            "title": "Payment Due",
            "message":
                "Your installment for Dubai Luxury Escape is due tomorrow.",
            "timestamp": "2025-08-29T12:00:00Z",
            "read": false,
            "action": {"label": "Pay Now", "url": "/payments/12345"},
          },
          {
            "id": "NTF002",
            "type": "trip_update",
            "title": "Flight Details Updated",
            "message":
                "Your flight for Thailand Delight departs 1 hour earlier.",
            "timestamp": "2025-08-28T15:00:00Z",
            "read": true,
          },
        ],
      };
      // print("Ressssssssssssssss : $response");

      if (response["status"] == "success") {
        // response.clear();
        final tabs = response["tabs"] as List;
        isInternational = false;
        final selectedTab = tabs.firstWhere(
          (tab) =>
              tab["id"] == (isInternational ? "international" : "domestic"),
        );
        print("Tab Id : $selectedTab");
        final jsonData = response['tabs'] as List;
        return jsonData.map((e) => TabItem.fromJson(e)).toList();
      } else {
        throw Exception("Failed to load destinations");
      }
    } catch (e) {
      throw Exception("Error fetching destinations: $e");
    }
  }
}
