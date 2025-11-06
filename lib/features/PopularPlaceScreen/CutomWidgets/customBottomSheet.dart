import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartrip/Common/AlertBox/alert.dart';
import 'package:smartrip/Common/Toast/commonToast.dart';
import 'package:smartrip/features/DashBoard/indexes/HomeScreen/CustomWidgets/Repos/homefetchRepo.dart';
import 'package:smartrip/features/DashBoard/indexes/SchemesScreen/CustomWidget/descriptionPop.dart';
import 'package:smartrip/utils/theme.dart';

void showBuySchemeBottomSheet(BuildContext context, Destination data) {
  // Parse chit scheme details
  final List<String> chitDetails = List<String>.from(data.chitsScheme ?? []);

  // Extract specific values
  String goal = chitDetails.firstWhere(
    (e) => e.contains('🎯'),
    orElse: () => '',
  );
  String duration = chitDetails.firstWhere(
    (e) => e.contains('🗓️'),
    orElse: () => '',
  );
  String members = chitDetails.firstWhere(
    (e) => e.contains('👥'),
    orElse: () => '',
  );
  String monthly = chitDetails.firstWhere(
    (e) => e.contains('💰'),
    orElse: () => '',
  );
  String payout = chitDetails.firstWhere(
    (e) => e.contains('🔁'),
    orElse: () => '',
  );

  String extractValue(String text) {
    final parts = text.split(':');
    return parts.length > 1 ? parts[1].trim() : '';
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      print(payout);
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.55,
          minChildSize: 0.45,
          maxChildSize: 0.60,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Text(
                    data.place ?? "Trip Scheme",
                    style: AppTheme.headingStyle.copyWith(fontSize: 20),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    data.location ?? '',
                    style: AppTheme.bodycontentStyle.copyWith(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Goal", style: AppTheme.bodycontentStyle),
                      Text(
                        extractValue(goal),
                        style: AppTheme.headingStyle.copyWith(fontSize: 16),
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
                        style: AppTheme.bodycontentStyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Members", style: AppTheme.bodycontentStyle),
                      Text(
                        extractValue(members),
                        style: AppTheme.bodycontentStyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
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
                        style: AppTheme.bodycontentStyle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
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
                              'Description :\n ${payout.split('🔁')[1]}',
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 0.5,
                                color: Colors.grey,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: Colors.blueAccent,
                                  size: 18.sp,
                                ),
                                Expanded(
                                  child: Text(
                                    payout.split('🔁')[1],
                                    maxLines: 1,
                                    style: AppTheme.bodycontentStyle.copyWith(
                                      color: Colors.grey[800],
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Divider(thickness: 1, color: Colors.grey[300]),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Total Goal", style: AppTheme.headingStyle),
                      ),
                      Expanded(
                        child: Text(
                          extractValue(goal),
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: AppTheme.headingStyle.copyWith(
                            fontSize: 20,
                            color: Colors.teal[700],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),
                  SafeArea(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Show toast first
                          ToastHelper.showToast(
                            context: context,
                            message: 'Proceeding to Payment...',
                          );

                          // Then pop the bottom sheet
                          Navigator.pop(context);

                          // Now show success dialog
                          if (context.mounted) {
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return CustomAlertBox(
                                  title: '💰 Scheme Joined',
                                  message:
                                      'Thank you! You’ve joined the scheme. Your monthly contribution will begin from this month.',
                                  confirmText: 'OK',
                                  onConfirm: () {
                                    Navigator.of(ctx).pop(); // close dialog
                                    Navigator.of(
                                      ctx,
                                    ).pop(); // close parent screen
                                  },
                                );
                              },
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF99431),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Pay  ${extractValue(monthly)}",
                          style: AppTheme.buttonTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ),
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
}
