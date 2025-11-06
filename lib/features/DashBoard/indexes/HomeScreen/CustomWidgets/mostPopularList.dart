import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartrip/features/DashBoard/indexes/HomeScreen/CustomWidgets/Repos/homefetchRepo.dart';
import 'package:smartrip/routes/app_router.dart';
import 'package:smartrip/utils/theme.dart';

class MostPopularListiview extends StatefulWidget {
  final double parentHeight;
  final double itemWidthRatio;
  final double itemHeightRatio;
  final List<Destination> dataList;

  const MostPopularListiview({
    super.key,
    required this.parentHeight,
    required this.dataList,
    this.itemWidthRatio = 0.6,
    this.itemHeightRatio = 0.9,
  });

  @override
  State<MostPopularListiview> createState() => _MostPopularListiviewState();
}

class _MostPopularListiviewState extends State<MostPopularListiview> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: widget.parentHeight,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double itemWidth = constraints.maxWidth * widget.itemWidthRatio;
          final double itemHeight =
              widget.parentHeight * widget.itemHeightRatio;

          return ListView.builder(
            itemCount: widget.dataList.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final item = widget.dataList[index];
              final imagePath = item.image ?? '';
              final place = item.place ?? '';
              final quote = item.quote ?? '';
              final location = item.location ?? '';

              return Stack(
                children: [
                  // ✅ Image card
                  Container(
                    margin: const EdgeInsets.all(8),
                    width: itemWidth,
                    height: itemHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        imagePath,
                        width: itemWidth,
                        height: itemHeight,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                  // ✅ Bottom info card
                  Positioned(
                    bottom: itemHeight * 0.1,
                    left: itemWidth * 0.08,
                    right: itemWidth * 0.08,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      width: itemWidth * 0.75,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Place & Quote
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '$place -',
                                  style: AppTheme.bodyTitle,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  quote,
                                  style: AppTheme.bodycontentStyle,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),

                          // Location
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.black54,
                                size: 18,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  location,
                                  style: AppTheme.bodycontentStyle.copyWith(
                                    fontSize: screenWidth * 0.032,
                                    color: Colors.black54,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),

                          // Explore button
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.pushRoute(
                                    PlaceDetailRoute(
                                      datalist: widget.dataList[index],
                                      tag: 'placeImage_$index',
                                      imagePath: imagePath,
                                      place: place,
                                      quote: quote,
                                      location: location,
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color.fromRGBO(
                                      249,
                                      148,
                                      49,
                                      1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Explore',
                                          style: AppTheme.buttonTextStyle,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      SvgPicture.asset(
                                        'assets/icons/route.svg',
                                        width: screenWidth * 0.06,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ✅ Like / Unlike button
                  Positioned(
                    top: screenHeight * 0.02,
                    right: screenWidth * 0.05,
                    child: SvgPicture.asset(
                      index % 2 == 0
                          ? 'assets/icons/like.svg'
                          : 'assets/icons/unlike.svg',
                      width: screenWidth * 0.06,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class SeasonalListiview extends StatelessWidget {
  final double parentHeight;
  final double itemWidthRatio;
  final double itemHeightRatio;
  final List<Destination> dataList;

  const SeasonalListiview({
    super.key,
    required this.parentHeight,
    required this.dataList,
    this.itemWidthRatio = 0.6,
    this.itemHeightRatio = 0.9,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: parentHeight,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double itemWidth = constraints.maxWidth * itemWidthRatio;
          final double itemHeight = parentHeight * itemHeightRatio;

          return ListView.builder(
            itemCount: dataList.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final item = dataList[index];
              final imagePath = item.image ?? '';
              final place = item.place ?? '';
              final seasonPeriod = item.location ?? '';

              return GestureDetector(
                onTap: () {
                  context.pushRoute(
                    PlaceDetailRoute(
                      tag: "Seasonal_$index",
                      imagePath: imagePath,
                      place: place,
                      quote: item.quote,
                      location: item.location,
                      datalist: item,
                    ),
                  );
                },
                child: Stack(
                  children: [
                    // Background image container
                    Container(
                      margin: EdgeInsets.all(screenWidth * 0.02),
                      width: itemWidth,
                      height: itemHeight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          imagePath,
                          width: itemWidth,
                          height: itemHeight,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Top right icon
                    Positioned(
                      top: itemHeight * 0.05,
                      right: itemWidth * 0.05,
                      child: SvgPicture.asset(
                        'assets/icons/route.svg',
                        width: screenWidth * 0.07, // scale icon
                      ),
                    ),

                    // Info card
                    Positioned(
                      bottom: itemHeight * 0.1,
                      left: itemWidth * 0.08,
                      right: itemWidth * 0.08,
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.02),
                        width: itemWidth * 0.75,
                        height: itemHeight * 0.45,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Place name
                            Text(
                              place,
                              style: AppTheme.bodyTitle.copyWith(
                                fontSize:
                                    screenWidth * 0.045, // responsive font
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            // Season period
                            Text(
                              '( $seasonPeriod )',
                              style: AppTheme.bodycontentStyle.copyWith(
                                fontSize: screenWidth * 0.035,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class FeaturedItem {
  final int id;
  final String place;
  final String quote;
  final String location;
  final String image;
  final String description;
  final List<String> chitsScheme;
  final List<String> budgetPlans;

  FeaturedItem({
    required this.id,
    required this.place,
    required this.quote,
    required this.location,
    required this.image,
    required this.description,
    required this.chitsScheme,
    required this.budgetPlans,
  });

  factory FeaturedItem.fromJson(Map<String, dynamic> json) {
    return FeaturedItem(
      id: json['id'],
      place: json['place'] ?? '',
      quote: json['quote'] ?? '',
      location: json['location'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      chitsScheme: List<String>.from(json['chitsScheme'] ?? []),
      budgetPlans: List<String>.from(json['budgetPlans'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'place': place,
      'quote': quote,
      'location': location,
      'image': image,
      'description': description,
      'chitsScheme': chitsScheme,
      'budgetPlans': budgetPlans,
    };
  }
}

// class FeaturedList extends StatelessWidget {
//   final List<FeaturedItem> items;

//   const FeaturedList({super.key, required this.items});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: List.generate(items.length, (index) {
//         final item = items[index];
//         return GestureDetector(
//           onTap: () {
//             context.pushRoute(
//               PlaceDetailRoute(
//                 datalist: item.toJson(),
//                 tag: 'place_$index',
//                 imagePath: item.image,
//                 place: item.place,
//                 quote: item.quote,
//                 location: item.location,
//               ),
//             );
//           },
//           child: Container(
//             padding: const EdgeInsets.all(5),
//             margin: EdgeInsets.only(
//               top: index == 0 ? 16 : 8,
//               bottom: index == items.length - 1 ? 8 : 0,
//             ),
//             decoration: BoxDecoration(
//               border: Border.all(width: 0.5, color: Colors.grey),
//               color: Theme.of(context).cardColor,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   offset: const Offset(0, 4),
//                   blurRadius: 10,
//                   spreadRadius: 2,
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: Hero(
//                     tag: 'place_$index',
//                     child: Image.asset(
//                       item.image,
//                       width: MediaQuery.of(context).size.width * 0.2,
//                       height: MediaQuery.of(context).size.height * 0.08,
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: MediaQuery.of(context).size.width * 0.05),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         item.place,
//                         style: AppTheme.bodyTitle,
//                         overflow: TextOverflow.ellipsis,
//                         maxLines: 1,
//                       ),
//                       const SizedBox(height: 4),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.location_on,
//                             color: Colors.grey,
//                             size: 18,
//                           ),
//                           const SizedBox(width: 4),
//                           Expanded(
//                             child: Text(
//                               item.location,
//                               style: AppTheme.bodycontentStyle.copyWith(
//                                 color: Colors.grey,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                               maxLines: 1,
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               '${item.chitsScheme.first}, ${item.chitsScheme.last}',
//                               style: AppTheme.bodycontentStyle.copyWith(
//                                 color: Colors.grey,
//                                 overflow: TextOverflow.ellipsis,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Text(
//                               '5+ benefits',
//                               style: AppTheme.bodycontentStyle.copyWith(
//                                 fontSize: 12,
//                                 color: Colors.grey,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 // const Spacer(),
//                 SvgPicture.asset(
//                   'assets/icons/explore.svg',
//                   width: 35,
//                   colorFilter: const ColorFilter.mode(
//                     Color.fromRGBO(249, 149, 49, 1),
//                     BlendMode.srcIn,
//                   ),
//                 ),
//                 const SizedBox(width: 15),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }
