import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartrip/features/DashBoard/indexes/SchemesScreen/schemesMainScreen.dart';
import 'package:smartrip/utils/theme.dart';

class SelectedMonthDetailsWidget extends ConsumerWidget {
  final Map<String, dynamic> scheme;

  const SelectedMonthDetailsWidget({super.key, required this.scheme});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedMonth = ref.watch(selectedMonthIndexProvider);

    if (selectedMonth == null) {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.2,
        margin: const EdgeInsets.only(top: 8, bottom: 30),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 0.8),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: 36,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 12),
            Text(
              "No Month Selected",
              style: AppTheme.bodyTitle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Please select a month to view details.",
              style: AppTheme.bodycontentStyle.copyWith(
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (selectedMonth >= scheme['paymentHistory'].length) {
      return Container(
        padding: EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.2,
        margin: const EdgeInsets.only(top: 8, bottom: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "🗓️ Upcoming Month",
              style: AppTheme.bodyTitle.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Center(
              child: Text(
                'Upcoming payments',
                style: AppTheme.bodycontentStyle.copyWith(color: Colors.grey),
              ),
            ),
          ],
        ),
      );
    }

    final sch = scheme['duration'];
    final pay = scheme['paymentHistory'];
    int count = 0;
    pay.forEach((e) {
      if (e['status'] == 'Paid' || e['status'] == 'Partial') {
        // print('I Printed $e');
        //  print(pay.length-1);
        count++;
        // Do something
      }
    });

    final payment = scheme['paymentHistory'][selectedMonth];

    final statusColor = switch (payment['status']) {
      'Paid' => Colors.green,
      'Partial' => Colors.orange,
      'Unpaid' => Colors.red,
      _ => Colors.grey,
    };

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Details',
                style: AppTheme.bodyTitle.copyWith(fontWeight: FontWeight.w700),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '$count/$sch',
                    style: AppTheme.bodyTitle.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text('Paid Months', style: AppTheme.bodycontentStyle),
                ],
              ),
            ],
          ),
        ),
        Container(
          // height: MediaQuery.of(context).size.height * 0.2,
          margin: const EdgeInsets.only(top: 8, bottom: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "🗓️ ${payment['month']}",
                  style: AppTheme.bodyTitle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Status: ${payment['status']}",
                      style: AppTheme.bodycontentStyle.copyWith(
                        color: statusColor,
                      ),
                    ),
                    Text(
                      payment['amount'],
                      style: AppTheme.bodycontentStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
                if (payment['usedFor'] != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    "📦 Used For: ${payment['usedFor']}",
                    style: AppTheme.bodycontentStyle,
                  ),
                ],
                if (payment['datePaid'] != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    "📅 Date Paid: ${payment['datePaid']}${payment['mode'] != null ? " | Mode: ${payment['mode']}" : ""}",
                    style: AppTheme.bodycontentStyle,
                  ),
                ],
                if (payment['remarks'] != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    "🧾 Remarks: ${payment['remarks']}",
                    style: AppTheme.bodycontentStyle,
                    maxLines: 4,
                  ),
                ],
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {
                      // Optional: open invoice or details
                    },
                    icon: const Icon(Icons.receipt_long, size: 20),
                    label: Text(
                      'View Invoice',
                      style: AppTheme.buttonTextStyle.copyWith(
                        color: statusColor,
                      ),
                    ),
                    style: TextButton.styleFrom(foregroundColor: statusColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
