import 'package:dollarx/config/config.dart';
import 'package:dollarx/constants/app_colors.dart';
import 'package:dollarx/modules/home/cubit/dashboard_refresh_cubit.dart';
import 'package:dollarx/modules/home/cubit/dashboard_refresh_state.dart';
import 'package:dollarx/modules/home/widgets/gainer_loaser_widget.dart';
import 'package:dollarx/modules/profile/pages/profile_page.dart';
import 'package:dollarx/ui/widgets/base_scaffold.dart';
import 'package:dollarx/ui/widgets/empty_widget.dart';
import 'package:dollarx/ui/widgets/loading_indicator.dart';
import 'package:dollarx/ui/widgets/on_click.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:dollarx/utils/extensions/extended_context.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../core/di/service_locator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int selectedIndex = 0;
  int _current = 0;

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
      create: (context) => DashBoardRefreshCubit(sl())..dashBoardRefresh(),
      child: BaseScaffold(
        safeAreaTop: true,
        hMargin: 0,
        body: BlocBuilder<DashBoardRefreshCubit, DashBoardRefreshState>(
          builder: (context, state) {
            if (state.dashBoardStatus == DashBoardRefreshStatus.loading) {
              return Center(
                child: LoadingIndicator(),
              );
            }
            if (state.dashBoardStatus == DashBoardRefreshStatus.success) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          color: AppColors.secondary),
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
                                  NavRouter.push(context, ProfilePage(isFromDashboard: false,));
                                },
                                child: CachedNetworkImage(
                                  imageUrl:
                                      state.dashboardModel!.user.profilePic.toString(),
                                  placeholder: (context, url) =>
                                      SizedBox(
                                        height: 70,
                                        width: 70,
                                        child: Stack(
                                          children: [
                                            Image.asset(
                                              'assets/images/png/slider_placeholder.png',width: double.infinity,
                                              fit: BoxFit.cover,),
                                            Center(
                                              child: CircularProgressIndicator(),
                                            ),
                                          ],
                                        ),
                                      ),
                                  errorWidget: (context, url, error) => ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(50)),
                                      child: Image.asset(
                                          'assets/images/png/placeholder.jpg',height: 70,width: 70,)),
                                  height: 70,width: 70,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.dashboardModel!.user.name
                                          .toString(),
                                      style: context.textTheme.headlineSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      state.dashboardModel!.user.email
                                          .toString(),
                                      style: context.textTheme.bodySmall,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Image.asset(
                                "assets/images/png/ic_notifications.png",
                                height: 34,
                              ),
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
                              style: context.textTheme.bodySmall),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                    "\$${state.dashboardModel!.totalInvestmentUsdt}",
                                    style: context.textTheme.headlineLarge
                                        ?.copyWith(fontSize: 28)),
                              ),
                              /*Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.darkGreen),
                                child: Text("+3.50%",
                                    style: context.textTheme.bodySmall
                                        ?.copyWith(
                                            color: AppColors.lightGreen)),
                              )*/
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                                height: 150.0,
                                viewportFraction: 1,
                                initialPage: 0,
                                reverse: false,
                                autoPlay: false,
                                enableInfiniteScroll: false,
                                scrollDirection: Axis.horizontal,
                                onPageChanged: (index, fn) {
                                  setState(() {
                                    _current = index;
                                  });
                                }),
                            items: state.dashboardModel!.sliders.map((imgUrl) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      'https://dollarax.com/${imgUrl.image}',
                                      placeholder: (context, url) =>
                                          SizedBox(
                                            height: 130,
                                            child: Stack(
                                              children: [
                                                Image.asset(
                                                  'assets/images/png/slider_placeholder.png',width: double.infinity,
                                                  fit: BoxFit.cover,),
                                                Center(
                                                  child: CircularProgressIndicator(),
                                                ),
                                              ],
                                            ),
                                          ),
                                      errorWidget: (context, url, error) => Image.asset(
                                        'assets/images/png/slider_placeholder.png',
                                        width: double.infinity,
                                        height: 130,
                                        fit: BoxFit.cover,),
                                      width: double.infinity,
                                      height: 130,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                  /*return ClipRRect(
                                    child: Image.network(
                                      'https://dollarax.com/${imgUrl.image}',
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(16)),
                                  );*/
                                },
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.secondary),
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.fieldColor),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/png/ic_deposit.png",
                                      width: 50,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("DollarAx Coin",
                                        style: context.textTheme.bodySmall),
                                    Text(
                                        "\$${state.dashboardModel!.walletBalanceDollarAx}",
                                        style: context.textTheme.headlineMedium)
                                  ],
                                )),
                                Container(
                                  width: 1,
                                  height: 76,
                                  color: AppColors.grey3,
                                ),
                                Expanded(
                                    child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/png/ic_profilt_loss.png",
                                      width: 50,
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text("Trade Profit & Loss",
                                        style: context.textTheme.bodySmall),
                                    Text(
                                        "\$${state.dashboardModel!.profitLossDollarAx}",
                                        style: context.textTheme.headlineMedium)
                                  ],
                                ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text("24h Markets",
                              style: context.textTheme.bodySmall),
                          SizedBox(
                            height: 6,
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
                                  text: 'Top Gainers',
                                ),
                                Tab(
                                  text: 'Top Losers',
                                ),
                              ],
                              onTap: (index) {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Column(
                            children: List.generate(selectedIndex == 0 ? 5 : 7,
                                (index) {
                              return GainerLoserListWidget();
                            }),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            if (state.dashBoardStatus == DashBoardRefreshStatus.error) {
              return Center(
                child: Text(state.message,style: TextStyle(
                  color: Colors.white
                ),),
              );
            }
            return EmptyWidget();
          },
        ),
      ),
    );
  }
}
