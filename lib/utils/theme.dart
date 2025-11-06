import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  // Heading Style
  static TextStyle headingStyle = TextStyle(
    fontFamily: 'Gantari',
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
    height: 1,
    letterSpacing: -0.2,
    color: const Color.fromRGBO(29, 29, 26, 1),
  );

  // Body Title Style
  static TextStyle bodyTitle = TextStyle(
    fontFamily: 'Gantari',
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    height: 1,
    letterSpacing: 0.0,
    color: Colors.black,
  );

  // Body Content Style
  static TextStyle bodycontentStyle = TextStyle(
    fontFamily: 'Gantari',
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0.0,
    color: Colors.black87,
  );

  // Button Text Style
  static TextStyle buttonTextStyle = TextStyle(
    fontFamily: 'Gantari',
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.3,
    color: Colors.white,
  );
}
