import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:smartrip/routes/app_router.dart';


@RoutePage()
class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen2> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      // context.replaceRoute(const SplashRoute3()); // navigate to Home
      checkLoginAndNavigate();
    });
  }

  Future<void> checkLoginAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // await Future.delayed(const Duration(seconds: 2)); // Optional splash delay

    if (isLoggedIn) {
      context.router.replaceAll([const DashBoardRoute()]);
    } else {
      context.router.replaceAll([const SplashRoute3()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
         statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.light
      ),
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Image.asset(
            "assets/splashes/splash2.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
