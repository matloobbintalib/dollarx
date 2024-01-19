import 'dart:io';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import 'bottom_nav_icon.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key, required this.selectedIndex, required this.onTap})
      : super(key: key);

  final int selectedIndex;
  final Function(int index) onTap;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: AppColors.fieldColor,
        border: Border(
          top: BorderSide(
            color: AppColors.secondary, // Adjust the color as needed
            width: 2, // Adjust the width as needed
          ),
        ),
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: BottomNavIcon(
              callback: () => widget.onTap(0),
              label: 'Investment',
              filledPath: 'assets/images/png/ic_investment.png',
              isSelected: widget.selectedIndex == 0,
            ),
          ),
          Expanded(
            child: BottomNavIcon(
              callback: () => widget.onTap(1),
              label: 'Referrals',
              filledPath: 'assets/images/png/ic_referrals.png',
              isSelected: widget.selectedIndex == 1,
            ),
          ),
          Expanded(
            child: BottomNavIcon(
              callback: () => widget.onTap(2),
              label: 'Trade',
              filledPath: 'assets/images/png/ic_trade.png',
              isSelected: widget.selectedIndex == 2,
            ),
          ),Expanded(
            child: BottomNavIcon(
              callback: () => widget.onTap(3),
              label: 'Home',
              filledPath: 'assets/images/png/ic_home.png',
              isSelected: widget.selectedIndex == 3,
            ),
          ),Expanded(
            child: BottomNavIcon(
              callback: () => widget.onTap(4),
              label: 'Wallet',
              filledPath: 'assets/images/png/ic_wallet.png',
              isSelected: widget.selectedIndex == 4,
            ),
          ),Expanded(
            child: BottomNavIcon(
              callback: () => widget.onTap(5),
              label: 'Profile',
              filledPath: 'assets/images/png/ic_profile.png',
              isSelected: widget.selectedIndex == 5,
            ),
          ),
        ],
      ),
    );
  }
}
