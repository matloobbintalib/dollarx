import 'package:dollarx/modules/history/cubit/bonus/bonus_history_cubit.dart';
import 'package:dollarx/modules/history/widget/bonus_history_widget.dart';
import 'package:dollarx/ui/widgets/empty_widget.dart';
import 'package:dollarx/ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../ui/widgets/custom_appbar.dart';
import '../cubit/bonus/bonus_history_state.dart';

class BonusHistoryPage extends StatelessWidget {
  const BonusHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BonusHistoryCubit(sl())..bonusHistory(),
      child: Scaffold(
        appBar: CustomAppbar(
          title: "Bonus History",
        ),
        backgroundColor: Colors.black,
        body: BlocBuilder<BonusHistoryCubit, BonusHistoryState>(
          builder: (context, state) {
            if(state.bonusHistoryStatus == BonusHistoryStatus.loading){
              return Center(child: LoadingIndicator(),);
            }
            if(state.bonusHistoryStatus == BonusHistoryStatus.success){
              return Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(top: 20),
                child: state.bonusHistoryList.isNotEmpty? ListView.builder(
                    itemCount: state.bonusHistoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BonusHistoryWidget(bonusHistoryModel: state.bonusHistoryList[index]);
                    }): Center(child: Text("Data Not Found!",style: TextStyle(
                  color: Colors.white
                ),),),
              );
            }
            if(state.bonusHistoryStatus == BonusHistoryStatus.error){
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
