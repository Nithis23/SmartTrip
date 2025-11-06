import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smartrip/utils/theme.dart';

class CustomAlertBox extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final VoidCallback onConfirm;
  final String cancelText;
  final VoidCallback? onCancel;
  final bool showCancel;

  const CustomAlertBox({
    super.key,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.onConfirm,
    this.cancelText = "Cancel",
    this.onCancel,
    this.showCancel = true,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        title,
        style: AppTheme.headingStyle.copyWith(fontSize: 20.sp),
      ),
      content: Text(message, style: AppTheme.bodycontentStyle),
      actionsPadding: const EdgeInsets.only(right: 12, bottom: 8),
      actions: [
        if (showCancel)
          TextButton(
            onPressed: onCancel ?? () => Navigator.of(context).pop(),
            child: Text(
              cancelText,
              style: AppTheme.bodycontentStyle.copyWith(color: Colors.grey),
            ),
          ),
        ElevatedButton(
          onPressed: onConfirm,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(249, 148, 49, 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            confirmText,
            style: AppTheme.buttonTextStyle.copyWith(fontSize: 14.sp),
          ),
        ),
      ],
    );
  }
}
