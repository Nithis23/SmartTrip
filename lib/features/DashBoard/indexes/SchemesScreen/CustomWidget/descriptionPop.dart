import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartrip/utils/theme.dart';

void showDescriptionPopup(BuildContext context, Offset position, String text) {
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;

  showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
      position.dx,
      position.dy,
      overlay.size.width - position.dx,
      overlay.size.height - position.dy,
    ),
    items: [
      PopupMenuItem(
        enabled: false,
        padding: EdgeInsets.zero,
        child: Container(
          width: 260.w,
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomPaint(
                painter: TrianglePainter(color: Colors.white),
                child: SizedBox(width: 10.w, height: 10.h),
              ),
              Text(
                text,
                style: AppTheme.bodycontentStyle.copyWith(
                  fontSize: 13.sp,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
    elevation: 0,
    color: Colors.transparent,
  );
}

class TrianglePainter extends CustomPainter {
  final Color color;
  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PaymentHistoryDialog extends StatelessWidget {
  final List<dynamic> paymentHistory;

  const PaymentHistoryDialog({super.key, required this.paymentHistory});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      backgroundColor: Colors.white,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Text(
              '🧾 Payment Timeline',
              style: AppTheme.headingStyle.copyWith(fontSize: 20.sp),
            ),
            const Divider(height: 20,thickness: 1,),
            Expanded(
              child: ListView.builder(
                itemCount: paymentHistory.length,
                itemBuilder: (context, index) {
                  final payment = paymentHistory[index];
                  final status = payment['status'] ?? 'Unpaid';
                  final statusColor =
                      {
                        'Paid': Colors.green,
                        'Partial': Colors.orange,
                        'Unpaid': Colors.red,
                      }[status] ??
                      Colors.grey;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Timeline Dot and Line
                      Column(
                        children: [
                          Container(
                            width: 14.w,
                            height: 14.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: statusColor,
                              border: Border.all(color: Colors.black12),
                            ),
                          ),
                          if (index != paymentHistory.length - 1)
                            Container(
                              width: 2,
                              height: 60.h,
                              color: Colors.grey.shade300,
                            ),
                        ],
                      ),
                      SizedBox(width: 12.w),
                      // Timeline Content
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 16.h),
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            // color: Colors.grey.shade100,
                            border: Border.all(color: Colors.grey.shade100,width: 2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                payment['month'] ?? 'Month ${index + 1}',
                                style: AppTheme.bodyTitle.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Status: $status",
                                    style: AppTheme.bodycontentStyle.copyWith(
                                      color: statusColor,
                                    ),
                                  ),
                                  Text(
                                    "${payment['amount'] ?? '--'}",
                                    style: AppTheme.bodycontentStyle.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: statusColor,
                                    ),
                                  ),
                                ],
                              ),
                              if (payment['datePaid'] != null)
                                Text(
                                  "📅 Date: ${payment['datePaid']}",
                                  style: AppTheme.bodycontentStyle,
                                ),
                              if (payment['mode'] != null)
                                Text(
                                  "💳 Mode: ${payment['mode']}",
                                  style: AppTheme.bodycontentStyle,
                                ),
                              if (payment['remarks'] != null)
                                Text(
                                  "🧾 Remarks: ${payment['remarks']}",
                                  style: AppTheme.bodycontentStyle,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Close',
                  style: AppTheme.buttonTextStyle.copyWith(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
