import 'package:dollarax/modules/investment_plan/cubit/investment_plan_cubit.dart';
import 'package:dollarax/modules/investment_plan/cubit/investment_plan_state.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../ui/widgets/custom_appbar.dart';
import '../widgets/investment_plan_widget.dart';

class InvestmentPlansPage extends StatelessWidget {
  const InvestmentPlansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      InvestmentPlanCubit(sl())
        ..investmentPlans(),
      child: Scaffold(
        appBar: CustomAppbar(
          title: "Investment Plan",
        ),
        backgroundColor: Colors.black,
        body: BlocBuilder<InvestmentPlanCubit, InvestmentPlanState>(
          builder: (context, state) {
           if(state.investmentPlanStatus == InvestmentPlanStatus.loading){
             return Center(child: LoadingIndicator(),);
           }
           if(state.investmentPlanStatus == InvestmentPlanStatus.success){
             return RefreshIndicator(
               onRefresh: (){
                 return Future.delayed(
                   Duration(seconds: 1),
                       () {
                     context.read<InvestmentPlanCubit>()
                       ..investmentPlans();
                   },
                 );
               },
               child: Container(
                 padding: EdgeInsets.only(top: 20),
                 height: MediaQuery.of(context).size.height,
                 child: state.investmentPlans.isNotEmpty ? ListView.builder(
                     itemCount: state.investmentPlans.length,
                     itemBuilder: (BuildContext context, int index) {
                       return InvestmentPlanWidget(investmentPlanModel:state.investmentPlans[index],);
                     }):Center(child: Text("Data Not Found!",style: TextStyle(
                     color: Colors.white
                 ),),),
               ),
             );
           }
           if(state.investmentPlanStatus == InvestmentPlanStatus.loading){
             return Center(child: Text(state.message, style: TextStyle(color: Colors.white),),);
           }
           return EmptyWidget();
          },
        ),
      ),

    );
  }
}
