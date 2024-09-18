import 'package:dollarax/config/config.dart';
import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/core/di/service_locator.dart';
import 'package:dollarax/modules/islamic_trade/cubit/islamic_trade_items/islamic_trade_items_cubit.dart';
import 'package:dollarax/modules/islamic_trade/cubit/islamic_trade_items/islamic_trade_items_state.dart';
import 'package:dollarax/modules/islamic_trade/pages/islamic_trade_history_page.dart';
import 'package:dollarax/modules/p2p_exchange/pages/p2p_page.dart';
import 'package:dollarax/modules/islamic_trade/pages/start_islamic_trade_page.dart';
import 'package:dollarax/modules/islamic_trade/widgets/islamic_trade_item_widget.dart';
import 'package:dollarax/ui/widgets/base_scaffold.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:dollarax/ui/widgets/on_click.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IslamicTradePage extends StatelessWidget {
  const IslamicTradePage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.secondary,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.light,
    ));
    return BlocProvider(
      create: (context) => IslamicTradeItemsCubit(sl())..getIslamicTradeItems(),
      child: BaseScaffold(
        safeAreaTop: true,
        hMargin: 0,
        backgroundColor: AppColors.secondary,
        body: BlocBuilder<IslamicTradeItemsCubit, IslamicTradeItemsState>(
          builder: (context, state) {
            if(state.islamicTradeItemsStatus == IslamicTradeItemsStatus.loading){
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Center(
                  child: LoadingIndicator(),
                ),
              );
            }
            if(state.islamicTradeItemsStatus == IslamicTradeItemsStatus.error){
              return Center(
                child: Text(state.message),
              );
            }
            if(state.islamicTradeItemsStatus == IslamicTradeItemsStatus.success){
              return RefreshIndicator(
                onRefresh: (){
                  return Future.delayed(
                    Duration(seconds: 1),
                        () {
                      context.read<IslamicTradeItemsCubit>().getIslamicTradeItems();
                    },
                  );
                },
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    OnClick(
                      onTap: () {
                        NavRouter.push(context, IslamicTradeHistoryPage());
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 120,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          height: 22,
                          margin: EdgeInsets.symmetric(vertical: 4)+EdgeInsets.only(bottom: 10,right: 10,top: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.black,
                          ),
                          child: Center(
                            child: Text(
                              'Trade History',
                              style: context.textTheme.bodySmall
                                  ?.copyWith(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, bottom: 12),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Trade Balance',
                                      style: context.textTheme.bodyLarge?.copyWith(color: Colors.black,fontWeight: FontWeight.w500)
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                      '${state.tradeBalance} USD',
                                      style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)
                                  )
                                ],
                              ),
                            )),
                        SizedBox(width: 6,),
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 12, right: 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      'Total ROI',
                                      style: context.textTheme.bodyLarge?.copyWith(color: Colors.black,fontWeight: FontWeight.w500)
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                      '${state.totalROI} USD',
                                      style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500)
                                  )
                                ],
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'All',
                                style: context.textTheme.bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                'Strategies',
                                style: context.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondary),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Expanded(child: ListView.builder(
                              itemCount: state.islamicTradeItems.length,
                              itemBuilder: (context, index) {
                                return IslamicWidgetItemWidget( islamicTradeItemModel:state.islamicTradeItems[index], onStartTrade: () {
                                  NavRouter.push(context, StartIslamicTradePage(tradeType: state.islamicTradeItems[index].title, item_id: state.islamicTradeItems[index].id,));
                                } ,);
                              })),
                        ],
                      ),
                    ))
                  ],
                ),
              );
            }
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
            );
          },
        ),
      ),
    );
  }
}
