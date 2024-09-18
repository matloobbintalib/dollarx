import 'package:dollarax/config/config.dart';
import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/history/pages/bonus_history_page.dart';
import 'package:dollarax/modules/history/pages/buy_sell_history_page.dart';
import 'package:dollarax/modules/history/pages/deposit_history_page.dart';
import 'package:dollarax/modules/history/pages/exchange_history_page.dart';
import 'package:dollarax/modules/history/pages/profit_history_page.dart';
import 'package:dollarax/modules/history/pages/trade_history_page.dart';
import 'package:dollarax/modules/history/pages/withdraw_history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/di/service_locator.dart';
import '../../../ui/widgets/custom_appbar.dart';
import '../../user/repository/user_account_repository.dart';
import '../widget/history_widget.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  UserAccountRepository _userAccountRepository = sl<UserAccountRepository>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "History",
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            HistoryWidget(
              onTap: () {
                NavRouter.push(context, DepositHistoryPage());
              },
              leading:Image.asset(
                'assets/images/png/currency_icon.png',
                height: 40,
                width: 40,
                color: AppColors.secondary,
              ) ,
              title: 'Deposit History',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(height: 20,),
            ),
            HistoryWidget(
              onTap: () {
                NavRouter.push(context, WithdrawHistoryPage());
              },
              leading: Image.asset(
                'assets/images/png/ic_withdraw_yellow.png',
                height: 40,
                width: 40,
                color: AppColors.secondary,
              ),
              title: 'Withdraw History',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(height: 20,),
            ),
            HistoryWidget(
              onTap: () {
                NavRouter.push(context, ProfitHistoryPage());
              },
              leading:Image.asset(
                'assets/images/png/ic_available_profit.png',
                height: 40,
                width: 40,
                color: AppColors.secondary,
              ) ,
              title: 'Profit History',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(height: 20,),
            ),
            HistoryWidget(
              onTap: () {
                NavRouter.push(context, BonusHistoryPage());
              },
              leading: Image.asset(
                'assets/images/png/ic_available_bonus.png',
                height: 40,
                width: 40,
                color: AppColors.secondary,
              ),
              title: 'Bonus History',
            ),Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(height: 20,),
            ),
            HistoryWidget(
              onTap: () {
                NavRouter.push(context, ExchangeHistoryPage());
              },
              leading: Image.asset('assets/images/png/ic_exchange.png',height: 40,
                width: 40,),
              title: 'Exchange History',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(height: 20,),
            ),
            HistoryWidget(
              onTap: () {
                NavRouter.push(context, TradeHistoryPage());
              },
              leading: Image.asset('assets/images/png/icon_trade.png',height: 40,
                width: 40,),
              title: 'Trade History',
            ),Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(height: 20,),
            ),
            HistoryWidget(
              onTap: () {
                NavRouter.push(context, BuySellHistoryPage());
              },
              leading: Image.asset('assets/images/png/ic_copy_trade_yellow.png',height: 40,
                width: 40,),
              title: 'P2P Buy Sell History',
            ),
          ],
        ),
      ),
    );
  }
}
