import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ToastHelper {
  static OverlayEntry? _overlayEntry;

  static void showToast({
    required BuildContext context,
    required String message,
    bool isSuccess = true,
    String iconPath = 'assets/icons/icon.png', // Your logo path
    bool useSvg = false,
    Duration duration = const Duration(seconds: 2),
  }) {
    _overlayEntry?.remove();

    _overlayEntry = OverlayEntry(
      builder: (_) => Positioned(
        bottom: 120,
        left: 50,
        right: 50,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSuccess
                  ?  Colors.black54
                  : Colors.redAccent,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // if (useSvg)
                //   SvgPicture.asset(
                //     iconPath,
                //     height: 30,
                //     width: 30,
                //     color: Colors.white,
                //   )
                // else
                //   Image.asset(
                //     iconPath,
                //     height: 30,
                //     width: 30,
                //   ),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    Timer(duration, () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }
}
