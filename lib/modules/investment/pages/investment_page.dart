import 'package:cached_network_image/cached_network_image.dart';
import 'package:dollarx/config/config.dart';
import 'package:dollarx/modules/deposit/pages/desposit_page.dart';
import 'package:dollarx/modules/history/pages/bonus_history_page.dart';
import 'package:dollarx/modules/history/pages/deposit_history_page.dart';
import 'package:dollarx/modules/history/pages/profit_history_page.dart';
import 'package:dollarx/modules/history/pages/withdraw_history_page.dart';
import 'package:dollarx/modules/investment/cubit/investment_cubit.dart';
import 'package:dollarx/modules/investment/cubit/investment_state.dart';
import 'package:dollarx/modules/investment/widgets/investment_widget.dart';
import 'package:dollarx/modules/investment/widgets/recent_transaction_widget.dart';
import 'package:dollarx/modules/investment_plan/pages/investment_plans.dart';
import 'package:dollarx/modules/withdraw/pages/withdraw_page.dart';
import 'package:dollarx/ui/widgets/base_scaffold.dart';
import 'package:dollarx/ui/widgets/custom_appbar.dart';
import 'package:dollarx/ui/widgets/empty_widget.dart';
import 'package:dollarx/ui/widgets/loading_indicator.dart';
import 'package:dollarx/ui/widgets/primary_button.dart';
import 'package:dollarx/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';
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
    return BlocProvider(
      create: (context) => InvestmentCubit(sl())..investmentDashboard(),
      child: BaseScaffold(
          safeAreaTop: true,
          hMargin: 0,
          appBar: CustomAppbar(
            title: "Investment",
            leftBorder: true,
            backArrow: false,
          ),
          body: BlocBuilder<InvestmentCubit, InvestmentState>(
            builder: (context, state) {
              if (state.investmentStatus == InvestmentStatus.loading) {
                return Center(
                  child: LoadingIndicator(),
                );
              }
              if (state.investmentStatus == InvestmentStatus.success) {
                return SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16)),
                          color: AppColors.secondary),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 10),
                                decoration: BoxDecoration(
                                    color: AppColors.secondary,
                                    border:
                                        Border.all(color: AppColors.white),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                            "Rank ${state.investmentModel!.userCurrentPlan.id}",
                                            style: context.textTheme.titleMedium
                                                ?.copyWith(
                                                    color: AppColors.white))),
                                    Expanded(
                                        child: Text(
                                      state
                                          .investmentModel!.userCurrentPlan.name
                                          .toString(),
                                      style: context.textTheme.titleMedium
                                          ?.copyWith(color: AppColors.white),
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
                          Text(
                              "\$${state.investmentModel!.totalInvestmentUsdt}",
                              style: context.textTheme.headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          Text("Available Balance",
                              style: context.textTheme.bodySmall?.copyWith(
                                  fontSize: 11, fontWeight: FontWeight.w300)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          InvestmentWidget(
                            iconPath:
                                "assets/images/png/ic_investment_yellow.png",
                            title: "Investment",
                            price:
                                "\$${state.investmentModel!.totalInvestmentUsdt}",
                            onTap: () {
                              NavRouter.push(context, DepositHistoryPage());
                            },
                          ),
                          InvestmentWidget(
                            iconPath: "assets/images/png/ic_profit_yellow.png",
                            title: "Profit",
                            price: "\$${state.investmentModel!.profitBalance}",
                            onTap: () {
                              NavRouter.push(context, ProfitHistoryPage());
                            },
                          ),
                          InvestmentWidget(
                            iconPath:
                                "assets/images/png/ic_referrals_investment.png",
                            title: "Referral Investment",
                            price:
                                "\$${state.investmentModel!.referralTotalAmount}",
                            onTap: () {
                              NavRouter.push(context, ReferralsPage(isFromDashboard: false,),);
                            },
                          ),
                          InvestmentWidget(
                            iconPath:
                                "assets/images/png/ic_referrals_bonus.png",
                            title: "Referral Bonus",
                            price: "\$${state.investmentModel!.bonus}",
                            onTap: () {
                              NavRouter.push(context, BonusHistoryPage());
                            },
                          ),
                          InvestmentWidget(
                            iconPath:
                                "assets/images/png/ic_withdraw_yellow.png",
                            title: "Withdrawals",
                            price:
                                "\$${state.investmentModel!.totalWithdrawUsdt.toString()}",
                            onTap: () {
                              NavRouter.push(context, WithdrawHistoryPage());
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          PrimaryButton(
                            onPressed: () {
                              NavRouter.push(context, InvestmentPlansPage());
                            },
                            title: 'Investment Plan',
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: AppColors.fieldColor,
                                borderRadius: BorderRadius.circular(
                                  8.0,
                                ),
                                border: Border.all(color: AppColors.secondary)),
                            child: TabBar(
                              dividerColor: AppColors.transparent,
                              controller: _tabController,
                              labelStyle: context.textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w500),
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: selectedIndex == 0
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.zero,
                                          topLeft: Radius.circular(8),
                                          bottomRight: Radius.zero,
                                          bottomLeft: Radius.circular(8)),
                                      color: AppColors.secondary,
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          topLeft: Radius.zero,
                                          bottomRight: Radius.circular(8),
                                          bottomLeft: Radius.zero),
                                      color: AppColors.secondary,
                                    ),
                              labelColor: Colors.black,
                              unselectedLabelColor: Colors.white,
                              tabs: [
                                Tab(
                                  text: 'Deposit',
                                ),
                                Tab(
                                  text: 'Withdraw',
                                ),
                              ],
                              onTap: (index) {
                                if (index == 0) {
                                  NavRouter.push(context, DepositPage());
                                } else if (index == 1) {
                                  NavRouter.push(context, WithdrawPage());
                                }
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 28,
                          ),
                          Row(
                            children: [
                              Text(
                                "Recent",
                                style: context.textTheme.bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Transaction",
                                style: context.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.secondary),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Divider(
                            thickness: 1.5,
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
                ));
              }
              if (state.investmentStatus == InvestmentStatus.error) {
                return Center(
                  child: Text(
                    state.message,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
              return EmptyWidget();
            },
          )),
    );
  }
}
