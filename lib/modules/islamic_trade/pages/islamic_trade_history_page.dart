import 'package:dollarax/config/routes/nav_router.dart';
import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/core/di/service_locator.dart';
import 'package:dollarax/modules/islamic_trade/cubit/end_islamic_trade/end_islamic_trade_cubit.dart';
import 'package:dollarax/modules/islamic_trade/cubit/end_islamic_trade/end_islamic_trade_state.dart';
import 'package:dollarax/modules/islamic_trade/cubit/islamic_trade_history/islamic_trade_history_cubit.dart';
import 'package:dollarax/modules/islamic_trade/cubit/islamic_trade_history/islamic_trade_history_state.dart';
import 'package:dollarax/modules/islamic_trade/models/end_islamic_trade_input.dart';
import 'package:dollarax/modules/islamic_trade/widgets/islamic_trade_history_widget.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:dollarax/ui/widgets/toast_loader.dart';
import 'package:dollarax/utils/display/display_utils.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IslamicTradeHistoryPage extends StatelessWidget {
  const IslamicTradeHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.secondary,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.light,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              IslamicTradeHistoryCubit(sl())..getIslamicTradeHistory(),
        ),
        BlocProvider(
          create: (context) => EndIslamicTradeCubit(sl()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondary,
          leading: IconButton(
            icon: Image.asset("assets/images/png/ic_back_arrow.png", width: 26,),
            onPressed: () {
              NavRouter.pop(context);
            },
          ),
          title: Text(
            'Copy Trade History',
            style: context.textTheme.titleLarge?.copyWith(color: Colors.black,fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: AppColors.secondary,
        body: BlocConsumer<EndIslamicTradeCubit, EndIslamicTradeState>(
          listener: (context, state) {
            if (state.endIslamicTradeStatus == EndIslamicTradeStatus.loading) {
              ToastLoader.show();
            } else if (state.endIslamicTradeStatus ==
                EndIslamicTradeStatus.success) {
              ToastLoader.remove();
              DisplayUtils.showToast(context, state.message);
              NavRouter.pop(context);
            } else if (state.endIslamicTradeStatus ==
                EndIslamicTradeStatus.error) {
              ToastLoader.remove();
              DisplayUtils.showToast(context, state.message);
            }
          },
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: (){
                return Future.delayed(
                  Duration(seconds: 1),
                      () {
                    context.read<IslamicTradeHistoryCubit>().getIslamicTradeHistory();
                  },
                );
              },
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context)
                .size.height,
                padding: EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: BlocBuilder<IslamicTradeHistoryCubit,
                    IslamicTradeHistoryState>(
                  builder: (context, historyState) {
                    if (historyState.islamicTradeHistoryStatus ==
                        IslamicTradeHistoryStatus.loading) {
                      return Center(
                        child: LoadingIndicator(),
                      );
                    }
                    if (historyState.islamicTradeHistoryStatus ==
                        IslamicTradeHistoryStatus.error) {
                      return Center(
                        child: Text(historyState.message),
                      );
                    }
                    if (historyState.islamicTradeHistoryStatus ==
                        IslamicTradeHistoryStatus.success) {
                      return historyState.islamicTradeHistory.isEmpty
                          ? Center(
                              child: Text('No Data Found!'),
                            )
                          : ListView.builder(
                              itemCount: historyState.islamicTradeHistory.length,
                              itemBuilder: (context, index) {
                                return IslamicTradeHistoryWidget(
                                  model: historyState.islamicTradeHistory[index],
                                  closeTrade: () {
                                    context.read<EndIslamicTradeCubit>()
                                      ..endIslamicTrade(EndIslamicTradeInput(
                                          trade_id: historyState
                                              .islamicTradeHistory[index].id
                                              .toString()));
                                  },
                                );
                              });
                    }
                    return EmptyWidget();
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
