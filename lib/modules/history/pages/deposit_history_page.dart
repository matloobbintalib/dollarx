import 'package:dollarx/modules/deposit/cubit/deposit_sold/deposit_sold_cubit.dart';
import 'package:dollarx/modules/deposit/cubit/deposit_sold/deposit_sold_state.dart';
import 'package:dollarx/modules/history/cubit/deposit/deposit_history_cubit.dart';
import 'package:dollarx/modules/history/widget/deposit_history_widget.dart';
import 'package:dollarx/ui/widgets/empty_widget.dart';
import 'package:dollarx/ui/widgets/loading_indicator.dart';
import 'package:dollarx/ui/widgets/toast_loader.dart';
import 'package:dollarx/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../ui/widgets/custom_appbar.dart';
import '../cubit/deposit/deposit_history_state.dart';

class DepositHistoryPage extends StatelessWidget {
  const DepositHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DepositHistoryCubit(sl())..depositHistory(),
        ),
        BlocProvider(
          create: (context) => DepositSoldCubit(sl()),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppbar(
          title: "Deposit History",
        ),
        backgroundColor: Colors.black,
        body: BlocConsumer<DepositSoldCubit, DepositSoldState>(
          listener: (context, depositSoldState) {
            if (depositSoldState.depositSoldStatus ==
                DepositSoldStatus.loading) {
              ToastLoader.show();
            }
            if (depositSoldState.depositSoldStatus ==
                DepositSoldStatus.success) {
              ToastLoader.remove();
              context.read<DepositHistoryCubit>()..depositHistory();
            }
            if (depositSoldState.depositSoldStatus ==
                DepositSoldStatus.error) {
              ToastLoader.remove();
              context.showSnackBar(depositSoldState.message);
            }
          },
          builder: (context, state) {
            return BlocBuilder<DepositHistoryCubit, DepositHistoryState>(
              builder: (context, state) {
                if (state.depositHistoryStatus ==
                    DepositHistoryStatus.loading) {
                  return Center(
                    child: LoadingIndicator(),
                  );
                }
                if (state.depositHistoryStatus ==
                    DepositHistoryStatus.success) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    padding: EdgeInsets.only(top: 20),
                    child: state.depositHistoryList.isNotEmpty
                        ? ListView.builder(
                            itemCount: state.depositHistoryList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return DepositHistoryWidget(
                                depositHistoryModel:
                                    state.depositHistoryList[index],
                                onSoldTap: () {
                                  context.read<DepositSoldCubit>()
                                    ..depositSave(
                                        state.depositHistoryList[index].id);
                                },
                              );
                            })
                        : Center(
                            child: Text(
                              "Data Not Found!",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                  );
                }
                if (state.depositHistoryStatus == DepositHistoryStatus.error) {
                  return Center(
                    child: Text(
                      state.message,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                return EmptyWidget();
              },
            );
          },
        ),
      ),
    );
  }
}
