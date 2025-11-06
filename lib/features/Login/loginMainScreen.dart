import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartrip/features/Login/customwidgets/stackwidgets.dart';
import 'package:smartrip/features/Login/loginContentColumn.dart'
    show LoginFormContent;

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ScrollController scroll;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController(text: 'mohan@gmail.com');
  final TextEditingController passwordController = TextEditingController(text: '123456');

  @override
  void initState() {
    super.initState();
    scroll = ScrollController();

    // Wait until the first frame is rendered to check scroll position
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scroll.hasClients && scroll.offset != 0.0) {
        scroll.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    scroll.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
          body: SafeArea(
            top: false,
            child: ImageStackLayout(
              imagePath: 'assets/banners/loginimage.jpg',
              scroll: scroll,
              child: LoginFormContent(
                formKey: _formKey,
                emailController: emailController,
                passwordController: passwordController,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
