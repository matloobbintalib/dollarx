import 'package:arc_progress_bar_new/arc_progress_bar_new.dart';
import 'package:dollarax/config/config.dart';
import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/core/di/service_locator.dart';
import 'package:dollarax/modules/deposit/pages/desposit_page.dart';
import 'package:dollarax/modules/exchange/pages/exchange_page.dart';
import 'package:dollarax/modules/history/pages/history_page.dart';
import 'package:dollarax/modules/home/widgets/gainer_loaser_widget.dart';
import 'package:dollarax/modules/p2p_exchange/pages/p2p_page.dart';
import 'package:dollarax/modules/transfer/pages/transfer_page.dart';
import 'package:dollarax/modules/wallet/cubit/wallet_details_cubit.dart';
import 'package:dollarax/modules/wallet/cubit/wallet_details_state.dart';
import 'package:dollarax/modules/wallet/widgets/feature_balance_widget.dart';
import 'package:dollarax/modules/wallet/widgets/wallet_icon_widget.dart';
import 'package:dollarax/modules/withdraw/pages/withdraw_page.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:dollarax/ui/widgets/primary_button.dart';
import 'package:dollarax/utils/display/display_utils.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  double _progressPercentage = 60;
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletDetailsCubit(sl())..walletDetailsData(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<WalletDetailsCubit, WalletDetailsState>(
          builder: (context, state) {
            if (state.walletDetailsStatus == WalletDetailsStatus.loading) {
              return Center(
                child: LoadingIndicator(),
              );
            }
            if (state.walletDetailsStatus == WalletDetailsStatus.success) {
              return RefreshIndicator(
                onRefresh: (){
                  return Future.delayed(
                    Duration(seconds: 1),
                        () {
                      context.read<WalletDetailsCubit>().walletDetailsData();
                    },
                  );
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20))),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              child: ArcProgressBar(
                                percentage: _progressPercentage,
                                arcThickness: 15,
                                innerPadding: 50,
                                strokeCap: StrokeCap.round,
                                handleSize: 10,
                                handleWidget: Container(
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                ),
                                bottomCenterWidget: Column(
                                  children: [
                                    Text(
                                      'Total Balance',
                                      style: context.textTheme.titleLarge
                                          ?.copyWith(fontSize: 18),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      '\$${state.walletModel!.totalBalanceUsd}',
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      style: context.textTheme.headlineLarge
                                          ?.copyWith(fontSize: 24, overflow: TextOverflow.ellipsis,color: Colors.black),
                                    ),
                                  ],
                                ),
                                foregroundColor: Colors.white,
                                backgroundColor: Color(0xFF9E7629),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  WalletIconWidget(
                                    iconPath:
                                        'assets/images/png/currency_icon.png',
                                    title: 'Deposit',
                                    onTab: () {
                                      NavRouter.push(context, DepositPage()).then((value) {
                                        context.read<WalletDetailsCubit>().walletDetailsData();
                                      });
                                    },
                                  ),
                                  WalletIconWidget(
                                    iconPath:
                                        'assets/images/png/ic_withdraw_yellow.png',
                                    title: 'Withdraw',
                                    onTab: () {
                                      NavRouter.push(context, WithdrawPage()).then((value) {
                                        context.read<WalletDetailsCubit>().walletDetailsData();
                                      });
                                    },
                                  ),
                                  WalletIconWidget(
                                    iconPath: 'assets/images/png/ic_transfer.png',
                                    title: 'P2P',
                                    onTab: () {
                                      NavRouter.push(context, P2PPage()).then((value) {
                                        context.read<WalletDetailsCubit>().walletDetailsData();
                                      });
                                      // NavRouter.push(context, TransferPage(currenciesList: state.walletModel!.currencyData, recentFundReceivers: state.walletModel!.recentFundReceivers,));
                                    },
                                  ),
                                  WalletIconWidget(
                                    iconPath: 'assets/images/png/ic_exchange.png',
                                    title: 'Exchange',
                                    onTab: () {
                                      NavRouter.push(context, ExchangePage(currenciesList: state.walletModel!.currencyData, totalBalanceUsd:  state.walletModel!.totalBalanceUsd,)).then((value) {
                                        context.read<WalletDetailsCubit>().walletDetailsData();
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 46,
                      ),
                      Container(
                          height: 220,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.walletModel!.currencyData.length,
                              itemBuilder: (BuildContext context, int index) {
                                return FeatureBalanceWidget(currencyModel: state.walletModel!.currencyData[index],);
                              })),
                      SizedBox(
                        height: 30,
                      ),
                      PrimaryButton(onPressed: (){
                        NavRouter.push(context, HistoryPage());
                      }, title: 'View History', hMargin: 20,),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
              );
            }
            if (state.walletDetailsStatus == WalletDetailsStatus.loading) {
              return Text(
                state.message,
                style: TextStyle(color: Colors.white),
              );
            }
            return EmptyWidget();
          },
        ),
      ),
    );
  }
}
