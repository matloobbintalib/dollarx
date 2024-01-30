
import 'package:dollarx/ui/widgets/empty_widget.dart';
import 'package:dollarx/ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../ui/widgets/custom_appbar.dart';
import '../cubit/profit/profit_history_cubit.dart';
import '../cubit/profit/profit_history_state.dart';
import '../widget/profit_history_widget.dart';

class ProfitHistoryPage extends StatelessWidget {
  const ProfitHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfitHistoryCubit(sl())..profitHistory(),
      child: Scaffold(
        appBar: CustomAppbar(
          title: "Profit History",
        ),
        backgroundColor: Colors.black,
        body: BlocBuilder<ProfitHistoryCubit, ProfitHistoryState>(
          builder: (context, state) {
            if(state.profitHistoryStatus == ProfitHistoryStatus.loading){
              return Center(child: LoadingIndicator(),);
            }
            if(state.profitHistoryStatus == ProfitHistoryStatus.success){
              return Container(
                padding: EdgeInsets.only(top: 20),
                height: MediaQuery.of(context).size.height,
                child:state.profitHistoryList.isNotEmpty? ListView.builder(
                    itemCount: state.profitHistoryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProfitHistoryWidget(profitHistoryModel: state.profitHistoryList[index]);
                    }):Center(child: Text("Data Not Found!",style: TextStyle(
                    color: Colors.white
                ),),),
              );
            }
            if(state.profitHistoryStatus == ProfitHistoryStatus.error){
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
