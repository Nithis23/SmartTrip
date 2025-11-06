import 'package:flutter/material.dart';

class ImageStackLayout extends StatelessWidget {
  final String imagePath;
  final Widget child;
  final double imageHeightFraction;
  final Alignment imageAlignment;
  final BoxFit imageFit;
  final ScrollController scroll;

  const ImageStackLayout({
    super.key,
    required this.imagePath,
    required this.child,
    required this.scroll,
    this.imageHeightFraction = 0.3,
    this.imageAlignment = Alignment.topCenter,
    this.imageFit = BoxFit.fitWidth,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: screenHeight * imageHeightFraction,
            child: FittedBox(
              fit: imageFit,
              alignment: imageAlignment,
              child: Image.asset(imagePath),
            ),
          ),
          Positioned(
            top: screenHeight * (imageHeightFraction - 0.02),
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              // Optional: add a background color here if needed
              child: SingleChildScrollView(
                controller: scroll,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
