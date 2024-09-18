import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dollarax/config/config.dart';
import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/deposit/pages/desposit_page.dart';
import 'package:dollarax/modules/home/cubit/dashboard_refresh_cubit.dart';
import 'package:dollarax/modules/home/cubit/dashboard_refresh_state.dart';
import 'package:dollarax/modules/home/models/home_assets_model.dart';
import 'package:dollarax/modules/home/widgets/home_assets_widget.dart';
import 'package:dollarax/modules/home/widgets/latest_deposit_widget.dart';
import 'package:dollarax/modules/home/widgets/latest_widthdrawals_widget.dart';
import 'package:dollarax/modules/profile/pages/profile_page.dart';
import 'package:dollarax/modules/withdraw/pages/withdraw_page.dart';
import 'package:dollarax/ui/widgets/base_scaffold.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:dollarax/ui/widgets/on_click.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;
  late TabController depositWithdrawTabController;
  int selectedIndex = 0;
  int depositWithdrawSelectedIndex = 1;
  int _current = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    depositWithdrawTabController =
        TabController(length: 2, vsync: this, initialIndex: 0);
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
      create: (context) => DashBoardRefreshCubit(sl())..dashBoardRefresh(),
      child: BaseScaffold(
        safeAreaTop: true,
        hMargin: 0,
        backgroundColor: AppColors.secondary,
        body: BlocBuilder<DashBoardRefreshCubit, DashBoardRefreshState>(
          builder: (context, state) {
            if (state.dashBoardStatus == DashBoardRefreshStatus.loading) {
              return Container(
                color: Colors.black,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: LoadingIndicator(),
                ),
              );
            }
            if (state.dashBoardStatus == DashBoardRefreshStatus.success) {
              return RefreshIndicator(
                onRefresh: (){
                  return Future.delayed(
                    Duration(seconds: 1),
                        () {
                      context.read<DashBoardRefreshCubit>()
                        ..dashBoardRefresh();
                    },
                  );
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                OnClick(
                                  onTap: () {
                                    NavRouter.push(
                                        context,
                                        ProfilePage(
                                          isFromDashboard: false,
                                        ));
                                  },
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    child: CachedNetworkImage(
                                      imageUrl: "https://dollarax.com/" +
                                          state.dashboardModel!.user.profilePic
                                              .toString(),
                                      placeholder: (context, url) => SizedBox(
                                        height: 70,
                                        width: 70,
                                        child: Stack(
                                          children: [
                                            Image.asset(
                                              'assets/images/png/placeholder.jpg',
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                            Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)),
                                              child: Image.asset(
                                                'assets/images/png/placeholder.jpg',
                                                height: 70,
                                                width: 70,
                                              )),
                                      height: 70,
                                      width: 70,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            state.dashboardModel!.user.name
                                                .toString(),
                                            style: context.textTheme.bodyLarge
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(width: 12,),
                                          Text(
                                            state.dashboardModel!.user.kycStatus
                                                .toString(),
                                            style: context.textTheme.bodySmall
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        state.dashboardModel!.user.referralId
                                            .toString(),
                                        style: context.textTheme.bodyLarge
                                            ?.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400),
                                      ),
                                      // Text(
                                      //   state.dashboardModel!.user.email
                                      //       .toString(),
                                      //   style: context.textTheme.bodyMedium
                                      //       ?.copyWith(
                                      //           fontWeight: FontWeight.w600),
                                      // ),
                                    ],
                                  ),
                                ),
                                /*Image.asset(
                                  "assets/images/png/ic_notifications.png",
                                  height: 40,
                                ),*/
                                /*SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  "assets/images/png/ic_scan.png",
                                  height: 34,
                                ),*/
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text("Total Balance",
                                style: context.textTheme.bodyLarge?.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w500)),
                            Text(
                                "${state.dashboardModel!.totalInvestmentUsdt} USD",
                                style: context.textTheme.headlineMedium
                                    ?.copyWith(fontWeight: FontWeight.w500))
                          ],
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                            color: AppColors.black),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: CarouselSlider(
                                options: CarouselOptions(
                                    height: 160.0,
                                    viewportFraction: 1,
                                    initialPage: 0,
                                    reverse: false,
                                    autoPlay: true,
                                    enableInfiniteScroll: false,
                                    scrollDirection: Axis.horizontal,
                                    onPageChanged: (index, fn) {
                                      setState(() {
                                        _current = index;
                                      });
                                    }),
                                items:
                                    state.dashboardModel!.sliders.map((imgUrl) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return CachedNetworkImage(
                                        imageUrl:
                                            'https://dollarax.com/${imgUrl.image}',
                                        placeholder: (context, url) => SizedBox(
                                          height: 130,
                                          child: Stack(
                                            children: [
                                              Image.asset(
                                                'assets/images/png/slider_placeholder.png',
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                              ),
                                              Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ],
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                          'assets/images/png/slider_placeholder.png',
                                          width: double.infinity,
                                          height: 130,
                                          fit: BoxFit.cover,
                                        ),
                                        width: double.infinity,
                                        height: 130,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                                child: Text(
                              'Your Assets',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            )),
                            SizedBox(
                              height: 20,
                            ),
                            HomeAssetsWidget(
                                homeAssetsModel: HomeAssetsModel(
                                    iconPath:
                                        'assets/images/png/home_page_investment.png',
                                    title: 'Investment',
                                    amount: state
                                        .dashboardModel!.investmentUSD)),
                            HomeAssetsWidget(
                                homeAssetsModel: HomeAssetsModel(
                                    iconPath:
                                        'assets/images/png/home_page _xau_trades.png',
                                    title: 'XAU Trade',
                                    amount: state
                                        .dashboardModel!.totalAuxTradeBalance.toString())),
                            HomeAssetsWidget(
                                homeAssetsModel: HomeAssetsModel(
                                    iconPath:
                                        'assets/images/png/ic_copy_trade_yellow.png',
                                    title: 'Copy Trade',
                                    amount: state.dashboardModel!.totalCopyTradeInvestmentUSD)),
                            HomeAssetsWidget(
                                homeAssetsModel: HomeAssetsModel(
                                    iconPath:
                                        'assets/images/png/home_page_wallet.png',
                                    title: 'Wallet Balance',
                                    amount: state
                                        .dashboardModel!.walletBalanceDollarAx.toString())),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: AppColors.secondary,
                                  )),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: OnClick(
                                    onTap: () {
                                      NavRouter.push(context, DepositPage());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4),
                                            bottomLeft: Radius.circular(4),
                                          ),
                                          border: Border.all(
                                            color: AppColors.secondary,
                                          )),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Deposits',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(
                                            'assets/images/png/home_page_deposits.png',
                                            width: 30,
                                            height: 30,
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Expanded(
                                      child: OnClick(
                                    onTap: () {
                                      NavRouter.push(context, WithdrawPage());
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(4),
                                            bottomRight: Radius.circular(4),
                                          ),
                                          border: Border.all(
                                            color: AppColors.secondary,
                                          )),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Withdrawals',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Image.asset(
                                            'assets/images/png/home_page_withdrawals.png',
                                            width: 30,
                                            height: 30,
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: LatestDepositWidget(
                                        list: state
                                            .dashboardModel!.latestDeposits)),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                    child: LatestWithdrawalsWidget(
                                        list: state
                                            .dashboardModel!.latestWithdrawals))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            if (state.dashBoardStatus == DashBoardRefreshStatus.error) {
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
        ),
      ),
    );
  }
}
