import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:smartrip/ProfileScreen/profileMainScreen.dart';
import 'package:smartrip/features/DashBoard/dashboardMainScreen.dart';
import 'package:smartrip/features/DashBoard/indexes/HomeScreen/CustomWidgets/Repos/homefetchRepo.dart';
import 'package:smartrip/features/Login/loginMainScreen.dart';
import 'package:smartrip/features/Passport/passportMainScreen.dart';
import 'package:smartrip/features/PopularPlaceScreen/mostPopularMainScreen.dart';
import 'package:smartrip/features/SignUp/signUpMainScreen.dart';
import 'package:smartrip/features/Splash_screens/splashscreen1.dart';
import 'package:smartrip/features/Splash_screens/splashscreen2.dart';
import 'package:smartrip/features/Splash_screens/splashscreen3.dart';
import 'package:smartrip/features/Splash_screens/splashscreen4.dart';
import 'package:smartrip/features/joinedscheme.dart';

part 'app_router.gr.dart'; // This should be the only part directive in this file.

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute1.page, initial: true), // Initial splash
    CustomRoute(
      page: SplashRoute2.page,
      transitionsBuilder: TransitionsBuilders.slideLeft,
      duration: Duration(milliseconds: 600),
    ),
    CustomRoute(
      page: SplashRoute3.page,
      transitionsBuilder: TransitionsBuilders.slideLeft,
      duration: Duration(milliseconds: 600),
    ),
    CustomRoute(
      page: SplashRoute4.page,
      transitionsBuilder: TransitionsBuilders.slideLeft,
      duration: Duration(milliseconds: 600),
    ),
    CustomRoute(
      page: LoginRoute.page,
      transitionsBuilder: TransitionsBuilders.slideLeft,
      duration: Duration(milliseconds: 300),
    ),
    CustomRoute(
      page: SignUpRoute.page,
      transitionsBuilder: TransitionsBuilders.slideLeft,
      duration: Duration(milliseconds: 300),
    ),
    CustomRoute(
      page: ProfileRoute.page,
      transitionsBuilder: TransitionsBuilders.slideLeft,
      duration: Duration(milliseconds: 300),
    ),
    CustomRoute(
      page: JoinedSchemeRoute.page,
      transitionsBuilder: TransitionsBuilders.slideLeft,
      duration: Duration(milliseconds: 300),
    ),
    CustomRoute(
      page: PlaceDetailRoute.page,
      transitionsBuilder: TransitionsBuilders.slideLeft,
      duration: Duration(milliseconds: 300),
    ),
    CustomRoute(
      page: DashBoardRoute.page,
      transitionsBuilder: TransitionsBuilders.zoomIn,
      duration: Duration(milliseconds: 300),
    ),
    CustomRoute(
      page: PassportKycRoute.page,
      transitionsBuilder: TransitionsBuilders.slideLeft,
      duration: Duration(milliseconds: 300),
    ),
    //  CustomRoute(
    //   page: GiftBoxesSchemeRoute.page,
    //   transitionsBuilder: TransitionsBuilders.slideLeft,
    //   duration: Duration(milliseconds: 300),
    // ),
    // CustomRoute(
    //   page: ProductDetailRoute.page,
    //   transitionsBuilder: TransitionsBuilders.slideLeft,
    //   duration: Duration(milliseconds: 300),
    // ),
  ];
}
