import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:smartrip/routes/app_router.dart';
import 'package:smartrip/utils/theme.dart';

@RoutePage()
class SplashScreen4 extends StatefulWidget {
  const SplashScreen4({super.key});

  @override
  State<SplashScreen4> createState() => _SplashScreen4State();
}

class _SplashScreen4State extends State<SplashScreen4> {
  final GlobalKey<SlideActionState> _loginKey = GlobalKey();
  final GlobalKey<SlideActionState> _signupKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: Stack(
            children: [
              SizedBox.expand(
                child: Image.asset(
                  "assets/splashes/splash4.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 130,
                child: SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.8, color: Colors.white70),
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    child: SlideAction(
                      key: _loginKey,
                      text: "Slide to Login",
                      textStyle: AppTheme.bodyTitle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      outerColor: Colors.black.withOpacity(0.4),
                      innerColor: Colors.transparent,
                      elevation: 4,
                      sliderButtonIcon: SvgPicture.asset(
                        'assets/icons/chevron_forward.svg',
                        height: 50,
                        // width: 24,
                      ),
                      submittedIcon: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 24,
                      ),

                      onSubmit: () {
                        // Navigate to Login
                        context.pushRoute(LoginRoute());
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                right: 20,
                bottom: 40,
                child: SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.8, color: Colors.white70),
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    child: SlideAction(
                      key: _signupKey,
                      text: "Slide to Sign Up",
                      textStyle: AppTheme.bodyTitle.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      outerColor: Colors.black.withOpacity(0.4),
                      innerColor: Colors.transparent,
                      elevation: 4,
                      sliderButtonIcon: SvgPicture.asset(
                        'assets/icons/chevron_forward.svg',
                        height: 50,
                        // width: 24,
                      ),
                      submittedIcon: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 24,
                      ),

                      onSubmit: () {
                        // Navigate to Sign Up
                        context.pushRoute(SignUpRoute());
                        return null;
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
