import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smartrip/LocalStorage/loginStorage.dart';
import 'package:smartrip/features/Login/customwidgets/textfields.dart';
import 'package:smartrip/routes/app_router.dart';
import 'package:smartrip/utils/theme.dart';
import 'package:smartrip/widgets/commonbutton.dart';

class LoginFormContent extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginFormContent({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  @override
  State<LoginFormContent> createState() => _LoginFormContentState();
}

class _LoginFormContentState extends State<LoginFormContent> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/logo/smartLogo1.jpg', width: 220, height: 90),
        Text('Welcome Back', style: AppTheme.headingStyle),
        Text('Please Login to your account', style: AppTheme.bodycontentStyle),
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: widget.formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  title: 'Email',
                  hintText: 'Enter your email',
                  controller: widget.emailController,
                ),
                const SizedBox(height: 25),
                CustomTextFormField(
                  title: 'Password',
                  hintText: 'Enter your password',
                  controller: widget.passwordController,
                  isPassword: true,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: check,
                          onChanged: (value) {
                            setState(() {
                              check = value!;
                            });
                          },
                          activeColor:
                              Colors
                                  .white, // Optional border color when checked
                          checkColor: Colors.white, // Checkmark color
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          fillColor: WidgetStateProperty.resolveWith<Color?>((
                            Set<WidgetState> states,
                          ) {
                            if (states.contains(WidgetState.selected)) {
                              return const Color.fromRGBO(
                                67,
                                77,
                                82,
                                1,
                              ); // Custom checked color
                            }
                            return Colors
                                .transparent; // Unchecked = transparent fill
                          }),
                        ),

                        Text(
                          'Remember me',
                          style: AppTheme.bodycontentStyle.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      child: Text(
                        'Forgot password?',
                        style: AppTheme.bodycontentStyle.copyWith(
                          color: Colors.grey,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomSubmitButton(
                  label: 'Submit',
                  onPressed: () async {
                    if (widget.formKey.currentState!.validate()) {
                      // Perform login or submission
                      context.replaceRoute(DashBoardRoute());
                      await saveLoginStatus();
                    }
                  },
                ),
                SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have account?",
                      style: AppTheme.bodycontentStyle.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: () {
                        context.pushRoute(SignUpRoute());
                        widget.formKey.currentState!.reset();
                      },
                      child: Text(
                        'SignUp',
                        style: AppTheme.bodycontentStyle.copyWith(
                          color: Color.fromRGBO(249, 148, 49, 1),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Text(
                  'Start your journey with SmarTrip today!\nJoin thousands who are saving smartly for their dream trips.',
                  textAlign: TextAlign.center,
                  style: AppTheme.bodycontentStyle.copyWith(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
