import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartrip/Common/AlertBox/alert.dart';
import 'package:smartrip/Common/Toast/commonToast.dart';
import 'package:smartrip/features/DashBoard/indexes/HomeScreen/CustomWidgets/Repos/homefetchRepo.dart';
import 'package:smartrip/features/DashBoard/indexes/SchemesScreen/CustomWidget/descriptionPop.dart';
import 'package:smartrip/utils/theme.dart';

void showBuySchemeBottomSheet(BuildContext context, Destination data) {
  final List<String> chitDetails = List<String>.from(data.chitsScheme ?? []);

  String goal = chitDetails.firstWhere((e) => e.contains('🎯'), orElse: () => '');
  String duration = chitDetails.firstWhere((e) => e.contains('🗓️'), orElse: () => '');
  String members = chitDetails.firstWhere((e) => e.contains('👥'), orElse: () => '');
  String monthly = chitDetails.firstWhere((e) => e.contains('💰'), orElse: () => '');
  String payout = chitDetails.firstWhere((e) => e.contains('🔁'), orElse: () => '');

  String extractValue(String text) {
    final parts = text.split(':');
    return parts.length > 1 ? parts[1].trim() : '';
  }

  int selectedUsers = 1;
  final memberDigits = RegExp(r'\d+').firstMatch(members ?? '');
  if (memberDigits != null) {
    selectedUsers = int.tryParse(memberDigits.group(0) ?? '1') ?? 1;
    if (selectedUsers <= 0) selectedUsers = 1;
  }

  bool showUserPicker = false;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: DraggableScrollableSheet(
          initialChildSize: 0.60,
          minChildSize: 0.35,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return StatefulBuilder(
              builder: (context, setState) {
                return SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle bar
                      Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      // Header Row + icon
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              data.place ?? "Trip Scheme",
                              style: AppTheme.headingStyle.copyWith(fontSize: 20),
                            ),
                          ),
                          IconButton(
                            tooltip: "Select number of users",
                            icon: const Icon(Icons.people),
                            onPressed: () {
                              setState(() {
                                showUserPicker = !showUserPicker;
                              });
                            },
                          ),
                        ],
                      ),

                      // Inline expansion for user count
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder: (child, anim) => SizeTransition(sizeFactor: anim, child: child),
                        child: showUserPicker
                            ? Container(
                          key: const ValueKey(1),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () {
                                  if (selectedUsers > 1) {
                                    setState(() {
                                      selectedUsers--;
                                    });
                                  }
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  "$selectedUsers",
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  setState(() {
                                    selectedUsers++;
                                  });
                                },
                              ),
                              const SizedBox(width: 16),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    showUserPicker = false;
                                  });
                                },
                                child: Text("Done",style: AppTheme.bodycontentStyle),
                              ),
                            ],
                          ),
                        )
                            : const SizedBox.shrink(key: ValueKey(0)),
                      ),

                      // Regular Info Fields
                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Goal", style: AppTheme.bodycontentStyle),
                          Text(
                            extractValue(goal),
                            style: AppTheme.bodycontentStyle.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Duration", style: AppTheme.bodycontentStyle),
                          Text(
                            extractValue(duration),
                            style: AppTheme.bodycontentStyle.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Members", style: AppTheme.bodycontentStyle),
                          Text(
                            "$selectedUsers person${selectedUsers > 1 ? 's' : ''}",
                            style: AppTheme.bodycontentStyle.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Monthly", style: AppTheme.bodycontentStyle),
                          Text(
                            extractValue(monthly),
                            style: AppTheme.bodycontentStyle.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Payout Option", style: AppTheme.bodycontentStyle),
                          const SizedBox(height: 8),
                          Expanded(
                            child: GestureDetector(
                              onTapDown: (TapDownDetails details) {
                                final position = details.globalPosition;
                                showDescriptionPopup(
                                  context,
                                  position,
                                  'Description :\n ${payout.split('🔁').length > 1 ? payout.split('🔁')[1] : payout}',
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(Icons.info_outline, size: 16),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      extractValue(payout),
                                      textAlign: TextAlign.end,
                                      style: AppTheme.bodycontentStyle.copyWith(fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                      const Divider(height: 1),
                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Goal", style: AppTheme.bodycontentStyle),
                          Text(
                            extractValue(goal),
                            style: AppTheme.bodycontentStyle.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.green[700],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            ToastHelper.showToast(
                              context: context,
                              message: 'Proceeding to Payment...',
                            );
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF9A37),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text(
                            "Pay ${extractValue(monthly)}",
                            style: AppTheme.buttonTextStyle.copyWith(fontSize: 16),
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
    },
  );
}

