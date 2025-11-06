import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartrip/features/DashBoard/indexes/HomeScreen/CustomWidgets/Repos/homefetchRepo.dart';
import 'package:smartrip/features/PopularPlaceScreen/CutomWidgets/customBottomSheet.dart';
import 'package:smartrip/utils/theme.dart';

@RoutePage()
class PlaceDetailScreen extends StatefulWidget {
  final String tag;
  final String imagePath;
  final String place;
  final String quote;
  final String location;
  final Destination datalist;

  const PlaceDetailScreen({
    super.key,
    required this.tag,
    required this.imagePath,
    required this.place,
    required this.quote,
    required this.location,
    required this.datalist,
  });

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.45,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32),
                        bottomRight: Radius.circular(32),
                      ),
                      child: Image.asset(widget.imagePath, fit: BoxFit.cover),
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.only(
                    //       bottomLeft: Radius.circular(32),
                    //       bottomRight: Radius.circular(32),
                    //     ),
                    //     gradient: LinearGradient(
                    //       colors: [
                    //         Colors.black.withOpacity(0.4),
                    //         Colors.transparent,
                    //       ],
                    //       begin: Alignment.bottomCenter,
                    //       end: Alignment.topCenter,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              leading: Container(
                margin: const EdgeInsets.only(top: 16),
                child: CircleAvatar(
                  backgroundColor: Colors.white70,
                  child: BackButton(color: Colors.black),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white70,
                    child: SvgPicture.asset('assets/icons/like.svg', width: 25),
                  ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.place,
                      style: AppTheme.headingStyle.copyWith(fontSize: 26),
                    ),
                    const SizedBox(height: 8),
                    if (widget.quote.isNotEmpty)
                      Text(
                        '"${widget.quote}"',
                        style: AppTheme.bodycontentStyle.copyWith(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.teal, size: 20),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            widget.location,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    buildSection(
                      "\uD83D\uDCDD Overview",
                      widget.datalist.description,
                    ),
                    const SizedBox(height: 24),
                    buildListSection(
                      "\uD83D\uDCE6 Chit Scheme",
                      widget.datalist.chitsScheme,
                      Icons.check_circle_outline,
                      Colors.green,
                    ),
                    const SizedBox(height: 24),
                    buildListSection(
                      "\uD83E\uDDF3\uFE0F Budget Travel Plan",
                      widget.datalist.budgetPlans,
                      Icons.monetization_on_outlined,
                      Colors.deepOrange,
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          showBuySchemeBottomSheet(context, widget.datalist);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF99431),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 36,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          "Start Planning",
                          style: AppTheme.buttonTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            // fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTheme.headingStyle),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            content,
            style: AppTheme.bodycontentStyle.copyWith(height: 1.6),
          ),
        ),
      ],
    );
  }

  Widget buildListSection(
    String title,
    List<dynamic> items,
    IconData icon,
    Color iconColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTheme.headingStyle),
        const SizedBox(height: 12),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 20),
                const SizedBox(width: 10),
                Expanded(child: Text(item, style: AppTheme.bodycontentStyle)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
