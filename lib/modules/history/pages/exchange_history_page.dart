import 'package:dollarax/core/di/service_locator.dart';
import 'package:dollarax/modules/history/cubit/bonus/bonus_history_state.dart';
import 'package:dollarax/modules/history/cubit/exchange/exchange_history_cubit.dart';
import 'package:dollarax/modules/history/cubit/exchange/exchange_history_state.dart';
import 'package:dollarax/modules/history/widget/exchange_history_widget.dart';
import 'package:dollarax/ui/widgets/custom_appbar.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExchangeHistoryPage extends StatelessWidget {
  const ExchangeHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExchangeHistoryCubit(sl())..exchangeHistory(),
      child: Scaffold(
        appBar: CustomAppbar(
          title: "Exchange History",
        ),
        backgroundColor: Colors.black,
        body: BlocBuilder<ExchangeHistoryCubit, ExchangeHistoryState>(
          builder: (context, state) {
            if (state.exchangeHistoryStatus == ExchangeHistoryStatus.loading) {
              return Center(child: LoadingIndicator(),);
            }
            if (state.exchangeHistoryStatus == ExchangeHistoryStatus.success) {
              return RefreshIndicator(
                onRefresh: (){
                  return Future.delayed(
                    Duration(seconds: 1),
                        () {
                      context.read<ExchangeHistoryCubit>()
                        ..exchangeHistory();
                    },
                  );
                },
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  padding: EdgeInsets.only(top: 20),
                  child: state.exchangeHistoryList.isNotEmpty ? ListView.builder(
                      itemCount: state.exchangeHistoryList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ExchangeHistoryWidget(exchangeHistoryModel: state
                            .exchangeHistoryList[index]);
                      }) : Center(child: Text("Data Not Found!", style: TextStyle(
                      color: Colors.white
                  ),),),
                ),
              );
            }
            if (state.exchangeHistoryStatus == ExchangeHistoryStatus.error) {
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
