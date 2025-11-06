import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartrip/Providers/bottomNavigationProvider.dart';
import 'package:smartrip/features/DashBoard/indexes/SchemesScreen/CustomWidget/descriptionPop.dart';
import 'package:smartrip/features/DashBoard/indexes/SchemesScreen/CustomWidget/selectedStatus.dart';
import 'package:smartrip/utils/theme.dart';

final selectedMonthIndexProvider = StateProvider.autoDispose<int?>((ref) {
  ref.onDispose(() {
    // Optional: clean-up or logging
    debugPrint("selectedMonthIndexProvider disposed");
  });
  return null;
});

class MySchemeScreen extends ConsumerStatefulWidget {
  const MySchemeScreen({super.key});

  @override
  ConsumerState<MySchemeScreen> createState() => _MySchemeScreenState();
}

class _MySchemeScreenState extends ConsumerState<MySchemeScreen> {
  ValueNotifier<bool> showChits = ValueNotifier(false);
  ValueNotifier<bool> showBudget = ValueNotifier(false);
  final ScrollController _scrollController = ScrollController();
  double itemWidth = 110; // width + margin

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void scrollToNextItem() {
    print('Scroll');
    if (_scrollController.hasClients) {
      setState(() {
        final double maxScroll = _scrollController.position.maxScrollExtent;
        double newOffset = _scrollController.offset + itemWidth;

        if (newOffset > maxScroll) newOffset = maxScroll;

        _scrollController.animateTo(
          newOffset,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> scheme = [
      {
        'id': 1,
        "place": "Paris – Love in the City of Lights",
        "location": "Eiffel Tower, Paris",
        'image': 'assets/banners/paris.jpg',
        'amount': 20000,
        'duration': 10,
        "description":
            "The Eiffel Tower is a wrought-iron lattice tower located in Paris, France. Standing at 330 meters tall, it was the tallest structure in the world until 1930. Today, it is one of the most iconic landmarks.",
        "chitsScheme": [
          "🎯 Goal: ₹2,00,000 (₹1,00,000 per person)",
          "🗓️ Duration: 10 months",
          "👥 Members: 2 people (1 + 1)",
          "💰 Monthly Contribution: ₹20,000 (₹10,000 / person)",
          "🔁 Payout Option: After 10 months OR alternate",
        ],
        "budgetPlans": [
          "✈️ Discounted round-trip airfare",
          "🏨 Budget hotel for 5 days",
          "🗼 Eiffel Tower entry",
          "🚋 Metro/tram transport",
          "🍞 Daily meals",
          "📸 DIY sightseeing",
        ],
        "paymentHistory": [
          {
            "month": "Jan",
            "status": "Paid",
            "amount": "₹20,000",
            "datePaid": "2025-01-05",
            "usedFor": "Flight Booking",
            "mode": "UPI",
            "remarks": "Early bird flight deal",
          },
          {
            "month": "Feb",
            "status": "Paid",
            "amount": "₹20,000",
            "datePaid": "2025-02-04",
            "usedFor": "Hotel Reservation",
            "mode": "Bank Transfer",
            "remarks": "Confirmed 5-day hotel booking",
          },
          {
            "month": "Mar",
            "status": "Unpaid",
            "amount": "₹20,000",
            "usedFor": "Eiffel Tower Entry + Local Transport",
            "remarks": "Due this month",
          },
          {
            "month": "Apr",
            "status": "Partial",
            "amount": "₹5,000",
            "datePaid": "2025-04-15",
            "usedFor": "Partial local sightseeing",
            "mode": "Card",
            "remarks": "Balance to be paid by April end",
          },
        ],
      },
    ];
    // for (var i = 0; i < 100; i++) {
    //   scheme.add(scheme.first);
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            ref.read(bottomNavProvider.notifier).state = 0;
          },
          icon: const Icon(
            Icons.arrow_circle_left_outlined,
            size: 30,
            color: Colors.black,
          ),
        ),
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'My Schemes',
                style: AppTheme.headingStyle.copyWith(fontSize: 20.sp),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: SizedBox(
                height: 40,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    for (
                      int i = 0;
                      i < (scheme.length > 4 ? 4 : scheme.length);
                      i++
                    )
                      Positioned(
                        left: i * 20.0,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundImage: AssetImage(scheme[i]['image']),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    if (scheme.length > 4)
                      Positioned(
                        left: 4 * 20.0,
                        child: CircleAvatar(
                          radius: 12.h,
                          backgroundColor: const Color.fromRGBO(255, 121, 2, 1),
                          child: Text(
                            '+${scheme.length - 4}',
                            style: AppTheme.bodycontentStyle.copyWith(
                              color: Colors.white,
                              fontSize: 10.sp,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              itemCount: scheme.length,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, expindex) {
                return Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child:
                  //  Builder(
                  //   builder: (context) {
                  //     bool expanded = false;
                  //     return
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ExpansionTile(
                      onExpansionChanged: (value) {
                        // setState(() => expanded = value);
                      },
                      initiallyExpanded: true,
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image section
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.asset(
                              scheme[expindex]['image'],
                              width: MediaQuery.of(context).size.width * 0.2,
                              height: 60.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 12.w),

                          // Text section
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  scheme[expindex]['place'],
                                  style: AppTheme.headingStyle.copyWith(
                                    fontSize: 18.sp,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 2,
                                ),
                                SizedBox(height: 4.h),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 16.sp,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 4.w),
                                    Expanded(
                                      child: Text(
                                        scheme[expindex]['location'],
                                        style: AppTheme.bodyTitle.copyWith(
                                          fontSize: 13.sp,
                                          color: Colors.grey,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image banner
                            Container(
                              height: 200.h,
                              decoration: BoxDecoration(),
                              child: Stack(
                                children: [
                                  // Background blurred image
                                  ClipRRect(
                                    child: Image.asset(
                                      scheme[expindex]['image'],
                                      width: double.infinity,
                                      height: 200.h,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  // Apply blur filter
                                  ClipRRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                        sigmaX: 12,
                                        sigmaY: 12,
                                      ),
                                      child: Container(
                                        width: double.infinity,
                                        height: 200.h,
                                        color: Colors.black.withOpacity(
                                          0.3,
                                        ), // Optional dark overlay
                                      ),
                                    ),
                                  ),
                                  // Foreground image (non-blurred)
                                  Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.r),
                                      child: Image.asset(
                                        scheme[expindex]['image'],
                                        width:
                                            MediaQuery.of(context).size.width *
                                            0.7,
                                        height: 160.h,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.r),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 12.h),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: GestureDetector(
                                      onTapDown: (TapDownDetails details) {
                                        final position = details.globalPosition;
                                        showDescriptionPopup(
                                          context,
                                          position,
                                          '${scheme[expindex]['description']}',
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 6.h,
                                          horizontal: 12.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent.withOpacity(
                                            0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.info_outline,
                                              color: Colors.blueAccent,
                                              size: 18.sp,
                                            ),
                                            SizedBox(width: 6.w),
                                            Text(
                                              'Place Description',
                                              style: AppTheme.bodyTitle
                                                  .copyWith(
                                                    fontSize: 14.sp,
                                                    color: Colors.blueAccent,
                                                    decoration:
                                                        TextDecoration
                                                            .underline,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 16.h),
                                  // Chit Scheme Toggle Section
                                  ValueListenableBuilder<bool>(
                                    valueListenable: showChits,
                                    builder:
                                        (_, expanded, __) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap:
                                                  () =>
                                                      showChits.value =
                                                          !expanded,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    expanded
                                                        ? Icons
                                                            .keyboard_arrow_down
                                                        : Icons
                                                            .keyboard_arrow_right,
                                                    color: Colors.black87,
                                                  ),
                                                  SizedBox(width: 4.w),
                                                  Text(
                                                    'Chit Scheme Details',
                                                    style: AppTheme.bodyTitle,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (expanded) ...[
                                              SizedBox(height: 8.h),
                                              ...List.generate(
                                                scheme[expindex]['chitsScheme']
                                                    .length,
                                                (index) => Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: 4.h,
                                                    left: 15.w,
                                                  ),
                                                  child: Text(
                                                    "• ${scheme[expindex]['chitsScheme'][index]}",
                                                    style:
                                                        AppTheme
                                                            .bodycontentStyle,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                  ),

                                  SizedBox(height: 16.h),

                                  // Budget Plans Toggle Section
                                  ValueListenableBuilder<bool>(
                                    valueListenable: showBudget,
                                    builder:
                                        (_, expanded, __) => Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap:
                                                  () =>
                                                      showBudget.value =
                                                          !expanded,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    expanded
                                                        ? Icons
                                                            .keyboard_arrow_down
                                                        : Icons
                                                            .keyboard_arrow_right,
                                                    color: Colors.black87,
                                                  ),
                                                  SizedBox(width: 4.w),
                                                  Text(
                                                    'Budget Plans',
                                                    style: AppTheme.bodyTitle,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (expanded) ...[
                                              SizedBox(height: 8.h),
                                              ...List.generate(
                                                scheme[expindex]['budgetPlans']
                                                    .length,
                                                (index) => Padding(
                                                  padding: EdgeInsets.only(
                                                    bottom: 4.h,
                                                    left: 15.w,
                                                  ),
                                                  child: Text(
                                                    "• ${scheme[expindex]['budgetPlans'][index]}",
                                                    style:
                                                        AppTheme
                                                            .bodycontentStyle,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                  ),
                                  SizedBox(height: 20.h),
                                  Text(
                                    'Payment Monthly History',
                                    style: AppTheme.headingStyle.copyWith(
                                      fontSize: 19.sp,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),

                                  //Pay Again container
                                  Container(
                                    margin: EdgeInsets.all(8),
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                            249,
                                            148,
                                            49,
                                            0.6,
                                          ), // orange
                                          spreadRadius:
                                              -5, // pull shadow inward
                                          blurRadius: 20,
                                          offset: Offset(0, -1),
                                          // inset: true, // Only works in Flutter 3.10+ with `inset_shadow` package or using `InnerShadow`
                                        ),
                                      ],
                                    ),
                                    // height:
                                    //     MediaQuery.of(context).size.height * 0.13,
                                    // color: Colors.grey,
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '30% Completed (3 of 10 months paid)',
                                                style: AppTheme.bodyTitle,
                                                maxLines: 2,
                                                overflow:
                                                    TextOverflow
                                                        .ellipsis, // Optional: to add "..." if it's too long
                                              ),
                                            ),
                                            Image.asset(
                                              'assets/icons/calendor.jpeg',
                                              width: 50,
                                              height: 30,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                print('Details');
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible:
                                                      true, // non-dismissible
                                                  builder:
                                                      (
                                                        context,
                                                      ) => PaymentHistoryDialog(
                                                        paymentHistory:
                                                            scheme[expindex]['paymentHistory'],
                                                      ),
                                                );
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 16,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                    color: const Color.fromRGBO(
                                                      255,
                                                      121,
                                                      2,
                                                      1,
                                                    ),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Details',
                                                  style: AppTheme
                                                      .buttonTextStyle
                                                      .copyWith(
                                                        fontSize: 14.sp,
                                                        color: Colors.black,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                      255,
                                                      121,
                                                      2,
                                                      0.90,
                                                    ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                              child: Text(
                                                'Pay Next',
                                                style: AppTheme.buttonTextStyle
                                                    .copyWith(fontSize: 14.sp),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 12.h),
                                  Text(
                                    'Monthly Status',
                                    style: AppTheme.headingStyle.copyWith(
                                      fontSize: 19.sp,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  //Monthly Paid status
                                  Consumer(
                                    builder: (context, ref, _) {
                                      final selectedIndex = ref.watch(
                                        selectedMonthIndexProvider,
                                      );
                                      final paymentHistory =
                                          scheme[expindex]['paymentHistory'];

                                      return Row(
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: 80,
                                              child: ListView.separated(
                                                controller: _scrollController,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    scheme[expindex]['duration'],
                                                separatorBuilder:
                                                    (_, __) => const SizedBox(
                                                      width: 10,
                                                    ),
                                                itemBuilder: (context, i) {
                                                  final payment =
                                                      i < paymentHistory.length
                                                          ? paymentHistory[i]
                                                          : null;
                                                  final status =
                                                      payment?['status'] ??
                                                      'Unpaid';
                                                  final isSelected =
                                                      selectedIndex == i;

                                                  IconData icon;
                                                  Color color;
                                                  String label;

                                                  if (status == 'Paid') {
                                                    icon = Icons.check_circle;
                                                    color = Colors.green;
                                                    label = 'Paid';
                                                  } else if (status ==
                                                      'Partial') {
                                                    icon = Icons.timelapse;
                                                    color = Colors.orange;
                                                    label = 'Partial';
                                                  } else {
                                                    icon = Icons.cancel;
                                                    color = Colors.grey;
                                                    label = 'Unpaid';
                                                  }

                                                  return GestureDetector(
                                                    onTap: () {
                                                      ref
                                                          .read(
                                                            selectedMonthIndexProvider
                                                                .notifier,
                                                          )
                                                          .state = i;
                                                    },
                                                    child: AnimatedContainer(
                                                      width:
                                                          MediaQuery.of(
                                                            context,
                                                          ).size.width *
                                                          0.2,
                                                      duration: const Duration(
                                                        milliseconds: 300,
                                                      ),
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 12,
                                                            vertical: 10,
                                                          ),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            isSelected
                                                                ? color
                                                                    .withOpacity(
                                                                      0.2,
                                                                    )
                                                                : Colors.white,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              12,
                                                            ),
                                                        border: Border.all(
                                                          color: color,
                                                          width: 1.5,
                                                        ),
                                                        boxShadow:
                                                            isSelected
                                                                ? [
                                                                  BoxShadow(
                                                                    color: color
                                                                        .withOpacity(
                                                                          0.9,
                                                                        ),
                                                                    blurRadius:
                                                                        6,
                                                                    offset:
                                                                        const Offset(
                                                                          0,
                                                                          3,
                                                                        ),
                                                                  ),
                                                                ]
                                                                : [],
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            icon,
                                                            color:
                                                                isSelected
                                                                    ? Colors
                                                                        .white
                                                                    : color,
                                                            size: 20,
                                                          ),
                                                          const SizedBox(
                                                            height: 4,
                                                          ),
                                                          Text(
                                                            payment?['month'] ??
                                                                'Month ${i + 1}',
                                                            style: AppTheme.bodyTitle.copyWith(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontSize: 12.sp,
                                                              color:
                                                                  isSelected
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black87,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            label,
                                                            style: AppTheme
                                                                .bodycontentStyle
                                                                .copyWith(
                                                                  fontSize:
                                                                      10.sp,
                                                                  color:
                                                                      isSelected
                                                                          ? Colors
                                                                              .white
                                                                          : Colors
                                                                              .black54,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: scrollToNextItem,
                                            child: Container(
                                              margin: const EdgeInsets.all(5),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 15,
                                                    horizontal: 8,
                                                  ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 0.5,
                                                  color: Colors.grey,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.grey.shade300,
                                              ),
                                              child: const Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.black87,
                                                size: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),

                                  SizedBox(height: 20),
                                  //Paid Specific month details
                                  SelectedMonthDetailsWidget(
                                    scheme: scheme[expindex],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  //   },
                  // ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
