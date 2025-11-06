import 'package:flutter/material.dart';
import 'package:smartrip/features/Login/customwidgets/textfields.dart';
import 'package:smartrip/utils/theme.dart';
import 'package:smartrip/widgets/commonbutton.dart';

class SignupFormContent extends StatefulWidget {
  final TextEditingController name;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final TextEditingController confirmpassword;

  const SignupFormContent({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.name,
    required this.confirmpassword,
  });

  @override
  State<SignupFormContent> createState() => _LoginFormContentState();
}

class _LoginFormContentState extends State<SignupFormContent> {
  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/logo/smartLogo1.jpg', width: 220, height: 90),
        Text('Sign Up', style: AppTheme.headingStyle),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: widget.formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  title: 'Name',
                  hintText: 'Enter your name',
                  controller: widget.name,
                ),
                const SizedBox(height: 25),
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
                const SizedBox(height: 25),
                CustomTextFormField(
                  title: 'Confirm Password',
                  hintText: 'Enter your password again',
                  controller: widget.confirmpassword,
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
                  ],
                ),
                const SizedBox(height: 20),
                CustomSubmitButton(
                  label: 'Submit',
                  onPressed: () {
                    if (widget.formKey.currentState!.validate()) {
                      // Perform login or submission
                    }
                  },
                ),
                SizedBox(height: 10),

              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
