import 'package:flutter/material.dart';
import 'package:smartrip/utils/theme.dart';

class CustomTextFormField extends StatefulWidget {
  final String title;
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;
  final void Function(String)? onFieldSubmitted; // <-- Add this

  const CustomTextFormField({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.onFieldSubmitted, // <-- Add this
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: AppTheme.bodyTitle),
        const SizedBox(height: 10),
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscureText : false,
          onFieldSubmitted: widget.onFieldSubmitted, // <-- Add this line

          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTheme.bodycontentStyle.copyWith(color: Colors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon:
                widget.isPassword
                    ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                    : null,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter ${widget.title.toLowerCase()}';
            }
            return null;
          },
        ),
      ],
    );
  }
}
