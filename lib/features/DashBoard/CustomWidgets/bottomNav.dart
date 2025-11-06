import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/theme.dart';

class BottomNavigationbar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigationbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static Color selectedColor1 = Color.fromRGBO(249, 148, 48, 1);
  static Color selectedColor = Colors.black;
  static const Color unselectedColor = Colors.grey;

  static const List<Map<String, String>> _navItems = [
    {
      'icon': 'assets/icons/homeicon.svg',
      'label': 'Home',
    }, //assets\icons\chevron_forward.svg
    {'icon': 'assets/icons/exploreicon.svg', 'label': 'Explore'},
    {'icon': 'assets/icons/wishlisticon.svg', 'label': 'Wishlist'},
    {'icon': 'assets/icons/schemeicon.svg', 'label': 'Scheme'},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8),
        margin: EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
              _navItems.asMap().entries.map((entry) {
                int index = entry.key;
                String iconPath = entry.value['icon']!;
                String label = entry.value['label']!;
                bool isSelected = currentIndex == index;

                return GestureDetector(
                  onTap: () => onTap(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? selectedColor1.withOpacity(0.3)
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child:
                        isSelected
                            ? Row(
                              children: [
                                SvgPicture.asset(
                                  iconPath,
                                  height: 24,
                                  width: 24,
                                  colorFilter: ColorFilter.mode(
                                    selectedColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  label,
                                  style: AppTheme.bodyTitle.copyWith(
                                    color: selectedColor,
                                  ),
                                ),
                              ],
                            )
                            : Stack(
                              clipBehavior: Clip.none,
                              children: [
                                SvgPicture.asset(
                                  iconPath,
                                  height: 24,
                                  width: 24,
                                  colorFilter: const ColorFilter.mode(
                                    unselectedColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                if (label == 'Wishlist') // 👈 Only for Wishlist
                                  Positioned(
                                    right: -2,
                                    top: -2,
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
