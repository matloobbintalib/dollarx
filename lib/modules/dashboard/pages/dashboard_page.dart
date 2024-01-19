import 'package:dollarx/modules/home/pages/home_page.dart';
import 'package:dollarx/modules/investment/pages/investment_page.dart';
import 'package:dollarx/modules/referalls/pages/referrals_page.dart';
import 'package:dollarx/ui/widgets/empty_page.dart';
import 'package:flutter/material.dart';
import '../widgets/navbar.dart';

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
      1 => ReferralsPage(),
      2 => EmptyPage(title: "Trade"),
      3 => HomePage(),
      4 => EmptyPage(title: "Wallet"),
      _ => EmptyPage(title: 'Profile'),
    };
    return page;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getCurrentPage(currentIndex),
      bottomNavigationBar: NavBar(selectedIndex: currentIndex, onTap: _onItemTapped),
    );
  }
}
