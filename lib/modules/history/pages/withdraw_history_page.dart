
import 'package:dollarx/ui/widgets/empty_widget.dart';
import 'package:dollarx/ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../ui/widgets/custom_appbar.dart';
import '../cubit/withdraw/withdraw_history_cubit.dart';
import '../cubit/withdraw/withdraw_history_state.dart';
import '../widget/withdraw_history_widget.dart';

class WithdrawHistoryPage extends StatelessWidget {
  const WithdrawHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WithdrawHistoryCubit(sl())..withdrawHistory(),
      child: Scaffold(
        appBar: CustomAppbar(
          title: "Withdraw History",
        ),
        backgroundColor: Colors.black,
        body: BlocBuilder<WithdrawHistoryCubit, WithdrawHistoryState>(
          builder: (context, state) {
            if(state.withdrawHistoryStatus == WithdrawHistoryStatus.loading){
              return Center(child: LoadingIndicator(),);
            }
            if(state.withdrawHistoryStatus == WithdrawHistoryStatus.success){
              return Container(
                padding: EdgeInsets.only(top: 20),
                height: MediaQuery.of(context).size.height,
                child: state.withdrawHistoryList.isNotEmpty ? ListView.builder(
                  itemCount: state.withdrawHistoryList.length,
                    itemBuilder: (BuildContext context, int index) {

                      return WithdrawHistoryWidget(withdrawHistoryModel: state.withdrawHistoryList[index]);
                    }):Center(child: Text("Data Not Found!",style: TextStyle(
                    color: Colors.white
                ),),),
              );
            }
            if(state.withdrawHistoryStatus == WithdrawHistoryStatus.error){
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
