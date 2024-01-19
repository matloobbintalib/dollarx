import 'package:dollarx/constants/app_colors.dart';
import 'package:flutter/material.dart';

class BottomNavbarDefault extends StatelessWidget {
  const BottomNavbarDefault({
    Key? key,
    required this.onTap,
    required this.currentIndex,
  }) : super(key: key);
  final Function(int index) onTap;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        backgroundColor: AppColors.fieldColor,
        elevation: 2,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                child: Image.asset(
                  "assets/images/png/ic_investment.png",
                  height: 24,
                ),
                margin: EdgeInsets.only(bottom: 6),
              ),
              label: 'Investment',
              backgroundColor: currentIndex == 0
                  ? AppColors.secondary
                  : AppColors.fieldColor),
          BottomNavigationBarItem(
              icon: Container(
                child: Image.asset(
                  "assets/images/png/ic_referrals.png",
                  height: 24,
                ),
                margin: EdgeInsets.only(bottom: 6),
              ),
              label: 'Referrals',
              backgroundColor: currentIndex == 1
                  ? AppColors.secondary
                  : AppColors.fieldColor
          ),
          BottomNavigationBarItem(
              icon: Container(
                child: Image.asset(
                  "assets/images/png/ic_trade.png",
                  height: 24,
                ),
                margin: EdgeInsets.only(bottom: 6),
              ),
              label: 'Trade',
              backgroundColor: currentIndex == 02
                  ? AppColors.secondary
                  : AppColors.fieldColor
          ),
          BottomNavigationBarItem(
              icon: Container(
                child: Image.asset(
                  "assets/images/png/ic_home.png",
                  height: 24,
                ),
                margin: EdgeInsets.only(bottom: 6),
              ),
              label: 'Home',
              backgroundColor: currentIndex == 3
                  ? AppColors.secondary
                  : AppColors.fieldColor
          ),
          BottomNavigationBarItem(
              icon: Container(
                child: Image.asset(
                  "assets/images/png/ic_wallet.png",
                  height: 24,
                ),
                margin: EdgeInsets.only(bottom: 6),
              ),
              label: 'Wallet',
              backgroundColor: currentIndex == 4
                  ? AppColors.secondary
                  : AppColors.fieldColor
          ),
          BottomNavigationBarItem(
              icon: Container(
                child: Image.asset(
                  "assets/images/png/ic_profile.png",
                  height: 24,
                ),
                margin: EdgeInsets.only(bottom: 6),
              ),
              label: 'Profile',
              backgroundColor: AppColors.secondary
          ),
        ],
      ),
    );
  }
}
