import 'package:dollarax/modules/home/pages/home_page.dart';
import 'package:dollarax/modules/investment/pages/investment_page.dart';
import 'package:dollarax/modules/islamic_trade/pages/islamic_trade_page.dart';
import 'package:dollarax/modules/profile/pages/profile_page.dart';
import 'package:dollarax/modules/trade/pages/gold_trade_page.dart';
import 'package:dollarax/modules/wallet/pages/wallet_page.dart';
import 'package:dollarax/ui/widgets/empty_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/navbar.dart';
import 'package:dollarax/modules/trade/pages/future_trade_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  int currentIndex = 3;

  Widget _getCurrentPage(int index) {
    final page = switch (index) {
      0 => InvestmentPage(),
      1 => IslamicTradePage(),
      2 => GoldTradePage(),
      3 => HomePage(),
      4 => WalletPage(),
      _ => ProfilePage(
          isFromDashboard: true,
        ),
    };
    return page;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentPage(currentIndex),
      bottomNavigationBar:
          NavBar(selectedIndex: currentIndex, onTap: _onItemTapped),
    );
  }
}
