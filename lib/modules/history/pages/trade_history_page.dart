import 'package:dollarax/modules/history/cubit/trade_history/trade_history_cubit.dart';
import 'package:dollarax/modules/history/cubit/trade_history/trade_history_state.dart';
import 'package:dollarax/modules/history/widget/trade_history_widget.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../ui/widgets/custom_appbar.dart';

class TradeHistoryPage extends StatelessWidget {
  const TradeHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TradeHistoryCubit(sl())..tradeHistory(),
      child: Scaffold(
        appBar: CustomAppbar(
          title: "Trade History",
        ),
        backgroundColor: Colors.black,
        body: BlocBuilder<TradeHistoryCubit, TradeHistoryState>(
          builder: (context, state) {
            if(state.tradeHistoryStatus == TradeHistoryStatus.loading){
              return Center(child: LoadingIndicator(),);
            }
            if(state.tradeHistoryStatus == TradeHistoryStatus.success){
              return RefreshIndicator(
                onRefresh: (){
                  return Future.delayed(
                    Duration(seconds: 1),
                        () {
                      context.read<TradeHistoryCubit>()
                        ..tradeHistory();
                    },
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(top: 20),
                  child: state.tradeHistoryList.isNotEmpty? ListView.builder(
                      itemCount: state.tradeHistoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TradeHistoryWidget(activeTradeModel: state.tradeHistoryList[index]);
                      }): Center(child: Text("Data Not Found!",style: TextStyle(
                      color: Colors.white
                  ),),),
                ),
              );
            }
            if(state.tradeHistoryStatus == TradeHistoryStatus.error){
              return Center(child: Text(
                state.message,style: TextStyle(color: Colors.white),
              ),);
            }

            return EmptyWidget();
          },
        ),
      ),
    );
  }
}
