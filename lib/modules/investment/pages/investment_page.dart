import 'package:cached_network_image/cached_network_image.dart';
import 'package:dollarax/config/config.dart';
import 'package:dollarax/modules/deposit/pages/desposit_page.dart';
import 'package:dollarax/modules/history/pages/bonus_history_page.dart';
import 'package:dollarax/modules/history/pages/deposit_history_page.dart';
import 'package:dollarax/modules/history/pages/profit_history_page.dart';
import 'package:dollarax/modules/history/pages/withdraw_history_page.dart';
import 'package:dollarax/modules/investment/cubit/investment_cubit.dart';
import 'package:dollarax/modules/investment/cubit/investment_state.dart';
import 'package:dollarax/modules/investment/widgets/investment_new_widget.dart';
import 'package:dollarax/modules/investment/widgets/recent_transaction_widget.dart';
import 'package:dollarax/modules/investment_plan/pages/investment_plans.dart';
import 'package:dollarax/modules/withdraw/pages/withdraw_page.dart';
import 'package:dollarax/ui/widgets/base_scaffold.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:dollarax/ui/widgets/primary_button.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/app_colors.dart';
import '../../../core/di/service_locator.dart';
import '../../referalls/pages/referrals_page.dart';
import '../models/investment_response.dart';

class InvestmentPage extends StatefulWidget {
  const InvestmentPage({super.key});

  @override
  State<InvestmentPage> createState() => _InvestmentPageState();
}

class _InvestmentPageState extends State<InvestmentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.secondary,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.light,
    ));
    return BlocProvider(
      create: (context) => InvestmentCubit(sl())..investmentDashboard(),
      child: BaseScaffold(
          safeAreaTop: true,
          hMargin: 0,
          backgroundColor: AppColors.secondary,
          body: BlocBuilder<InvestmentCubit, InvestmentState>(
            builder: (context, state) {
              if (state.investmentStatus == InvestmentStatus.loading) {
                return Container(
                  color: Colors.black,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: LoadingIndicator(),
                  ),
                );
              }
              if (state.investmentStatus == InvestmentStatus.success) {
                return RefreshIndicator(
                  onRefresh: (){
                    return Future.delayed(
                      Duration(seconds: 1),
                          () {
                        context.read<InvestmentCubit>()
                          ..investmentDashboard();
                      },
                    );
                  },
                  child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            color: AppColors.secondary,
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Column(
                          children: [
                            Text(
                              'Investment',
                              style: context.textTheme.titleLarge
                                  ?.copyWith(color: Colors.black),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 10),
                                  decoration: BoxDecoration(
                                      color: AppColors.secondary,
                                      border: Border.all(color: AppColors.black),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4))),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Text(
                                              "Rank ${state.investmentModel!.userCurrentPlan.id}",
                                              style: context.textTheme.titleMedium
                                                  ?.copyWith(
                                                      color: AppColors.black))),
                                      Expanded(
                                          child: Text(
                                        state
                                            .investmentModel!.userCurrentPlan.name
                                            .toString(),
                                        style: context.textTheme.titleMedium
                                            ?.copyWith(color: AppColors.black),
                                        textAlign: TextAlign.right,
                                      ))
                                    ],
                                      ),
                                    ),
                                    CachedNetworkImage(
                                      imageUrl: "https://dollarax.com/" +
                                          state.investmentModel!.userCurrentPlan
                                              .imgUrl,
                                      placeholder: (context, url) =>
                                      new CircularProgressIndicator(),
                                      errorWidget: (context, url, error) => ClipRRect(
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                          child: Image.asset(
                                            'assets/images/png/placeholder.jpg',
                                            width: 60,
                                        height: 60,
                                      )),
                                  width: 60,
                                  height: 60,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text("Available Balance",
                                style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                            Text(
                                "${state.investmentModel!.totalInvestmentUsdt} USD",
                                style: context.textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10) +
                            EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: AppColors.black),
                        child: Column(
                          children: [
                            InvestmentNewWidget(
                              iconPath:
                                  "assets/images/png/ic_investment_yellow.png",
                              title: "Investment",
                              price:
                                  "${state.investmentModel!.totalInvestmentUsdt} USD",
                              onTap: () {
                                NavRouter.push(context, DepositHistoryPage());
                              },
                            ),
                                InvestmentNewWidget(
                              iconPath: "assets/images/png/ic_profit_yellow.png",
                              title: "Profit",
                              price:
                                  "${state.investmentModel!.profitBalance} USD",
                              onTap: () {
                                NavRouter.push(context, ProfitHistoryPage());
                              },
                            ),
                                InvestmentNewWidget(
                              iconPath:
                                  "assets/images/png/ic_referrals_investment.png",
                              title: "Referral Investment",
                              price:
                                  "${state.investmentModel!.referralTotalAmount} USD",
                              onTap: () {
                                NavRouter.push(
                                  context,
                                  ReferralsPage(
                                    isFromDashboard: false,
                                  ),
                                );
                              },
                            ),
                                InvestmentNewWidget(
                              iconPath:
                                  "assets/images/png/ic_referrals_bonus.png",
                              title: "Referral Bonus",
                              price: "${state.investmentModel!.bonus} USD",
                              onTap: () {
                                NavRouter.push(context, BonusHistoryPage());
                              },
                            ),
                            InvestmentNewWidget(
                              iconPath:
                                  "assets/images/png/ic_withdraw_yellow.png",
                              title: "Withdrawals",
                              price:
                                  "${state.investmentModel!.totalWithdrawUsdt.toString()} USD",
                              onTap: () {
                                NavRouter.push(context, WithdrawHistoryPage());
                              },
                            ),
                            SizedBox(
                              height: 16,
                            ),

                            PrimaryButton(
                              onPressed: () {
                                NavRouter.push(
                                  context,
                                  ReferralsPage(
                                    isFromDashboard: false,
                                  ),
                                );
                              },
                              title: 'Referrals',
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: PrimaryButton(
                                    onPressed: () {
                                      NavRouter.push(context, DepositPage());
                                    },
                                    title: 'Deposit',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    borderRadius: 4,
                                  ),
                                ),
                                Expanded(
                                  child: PrimaryButton(
                                    onPressed: () {
                                      NavRouter.push(context, WithdrawPage());
                                    },
                                    title: 'Withdraw',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    backgroundColor: Colors.black,
                                    borderRadius: 4,
                                    titleColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16,),
                            PrimaryButton(
                              onPressed: () {
                                NavRouter.push(context, InvestmentPlansPage());
                              },
                              title: 'Investment Plan',
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              backgroundColor: Colors.black,
                              borderRadius: 4,
                              titleColor: Colors.white,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Recent",
                                  style: context.textTheme.bodySmall
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Transaction",
                                      style: context.textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.secondary),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Divider(
                                  thickness: 1,
                                  color: AppColors.grey3,
                                ),
                                SizedBox(
                                  height: 26,
                                ),
                                Column(
                                  children: List.generate(
                                      state.investmentModel!.latestTransData.length,
                                          (index) {
                                        LatestTransDatum model =
                                        state.investmentModel!.latestTransData[index];
                                        String iconPath =
                                            "assets/images/png/ic_profit_yellow.png";
                                        if (model.type.toLowerCase() == "profit") {
                                          iconPath =
                                          "assets/images/png/ic_profit_yellow.png";
                                        } else if (model.type.toLowerCase() ==
                                            "deposit") {
                                          iconPath =
                                          "assets/images/png/ic_available_balance.png";
                                        } else if (model.type.toLowerCase() ==
                                            "withdraw") {
                                          iconPath =
                                          "assets/images/png/ic_withdraw_yellow.png";
                                        } else if (model.type.toLowerCase() == "bonus") {
                                          iconPath =
                                          "assets/images/png/ic_referrals_bonus.png";
                                        }
                                        return RecentTransactionWidget(
                                          latestTransDatum: model,
                                          iconPath: iconPath,
                                        );
                                      }),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                );
              }
              if (state.investmentStatus == InvestmentStatus.error) {
                return Container(
                  color: Colors.black,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }
              return EmptyWidget();
            },
          )),
    );
  }
}
