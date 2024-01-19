import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/constants.dart';

class BottomNavbarPrimary extends StatelessWidget {
  const BottomNavbarPrimary({
    Key? key,
    required this.onTap,
    required this.currentIndex,
  }) : super(key: key);
  final Function(int index) onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/svg/ic-journal.svg',
            height: 22,
            colorFilter: ColorFilter.mode(
              currentIndex == 2 ? colorScheme.primary : AppColors.black,
              BlendMode.srcIn,
            ),
          ),
          label: 'Journal',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/png/bot.png',
            height: 22,
            color: currentIndex == 1 ? colorScheme.primary : AppColors.black,
          ),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/svg/ic-profile.svg',
            height: 22,
            colorFilter: ColorFilter.mode(
              currentIndex == 2 ? colorScheme.primary : AppColors.black,
              BlendMode.srcIn,
            ),
          ),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'assets/images/svg/ic-profile.svg',
            height: 22,
            colorFilter: ColorFilter.mode(
              currentIndex == 2 ? colorScheme.primary : AppColors.black,
              BlendMode.srcIn,
            ),
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
