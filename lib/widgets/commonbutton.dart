import 'package:flutter/material.dart';
import 'package:smartrip/utils/theme.dart';

class CustomSubmitButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double widthFactor;

  const CustomSubmitButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.widthFactor = 0.4, // default width as 40% of screen
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * widthFactor,
      child: ElevatedButton.icon(
        label: Text(label, style: AppTheme.buttonTextStyle),
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll(
            Color.fromRGBO(249, 178, 49, 1),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
