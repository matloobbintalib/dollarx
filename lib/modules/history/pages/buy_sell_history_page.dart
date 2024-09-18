import 'package:dollarax/core/di/service_locator.dart';
import 'package:dollarax/modules/history/cubit/bonus/bonus_history_state.dart';
import 'package:dollarax/modules/history/cubit/buy_sell_history/buy_sell_history_cubit.dart';
import 'package:dollarax/modules/history/cubit/buy_sell_history/buy_sell_history_state.dart';
import 'package:dollarax/modules/history/cubit/exchange/exchange_history_cubit.dart';
import 'package:dollarax/modules/history/cubit/exchange/exchange_history_state.dart';
import 'package:dollarax/modules/history/widget/buy_sell_history_widget.dart';
import 'package:dollarax/modules/history/widget/exchange_history_widget.dart';
import 'package:dollarax/ui/widgets/custom_appbar.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuySellHistoryPage extends StatelessWidget {
  const BuySellHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BuySellHistoryCubit(sl())..buySellExchangeHistory(),
      child: Scaffold(
        appBar: CustomAppbar(
          title: "P2P Buy Sell History",
        ),
        backgroundColor: Colors.black,
        body: BlocBuilder<BuySellHistoryCubit, BuySellHistoryState>(
          builder: (context, state) {
            if (state.buySellHistoryStatus == BuySellHistoryStatus.loading) {
              return Center(child: LoadingIndicator(),);
            }
            if (state.buySellHistoryStatus == BuySellHistoryStatus.success) {
              return RefreshIndicator(
                onRefresh: (){
                  return Future.delayed(
                    Duration(seconds: 1),
                        () {
                      context.read<BuySellHistoryCubit>()
                        ..buySellExchangeHistory();
                    },
                  );
                },
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  padding: EdgeInsets.only(top: 20),
                  child: state.buySellHistoryList.isNotEmpty ? ListView.builder(
                      itemCount: state.buySellHistoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BuySellHistoryWidget(exchangeHistoryModel: state
                            .buySellHistoryList[index]);
                      }) : Center(child: Text("Data Not Found!", style: TextStyle(
                      color: Colors.white
                  ),),),
                ),
              );
            }
            if (state.buySellHistoryStatus == BuySellHistoryStatus.error) {
              return Center(child: Text(
                state.message, style: TextStyle(color: Colors.white),
              ),);
            }

            return EmptyWidget();
          },
        ),
      ),
    );
  }
}
