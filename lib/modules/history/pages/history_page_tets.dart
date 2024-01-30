import 'package:dollarx/config/config.dart';
import 'package:dollarx/modules/history/pages/bonus_history_page.dart';
import 'package:dollarx/modules/history/pages/deposit_history_page.dart';
import 'package:dollarx/modules/history/pages/profit_history_page.dart';
import 'package:dollarx/modules/history/pages/withdraw_history_page.dart';
import 'package:flutter/material.dart';

import '../../../core/di/service_locator.dart';
import '../../../ui/widgets/custom_appbar.dart';
import '../../user/repository/user_account_repository.dart';
import '../widget/history_widget.dart';

class HistoryPageTets extends StatefulWidget {
  const HistoryPageTets({super.key});

  @override
  State<HistoryPageTets> createState() => _HistoryPageTetsState();
}

class _HistoryPageTetsState extends State<HistoryPageTets> {
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
              leadingPath: 'assets/images/png/currency_icon.png',
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
              leadingPath: 'assets/images/png/ic_withdraw_yellow.png',
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
              leadingPath: 'assets/images/png/ic_available_profit.png',
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
              leadingPath: 'assets/images/png/ic_available_bonus.png',
              title: 'Bonus History',
            ),
          ],
        ),
      ),
    );
  }
}
