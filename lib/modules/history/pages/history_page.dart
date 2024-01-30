import 'package:dollarx/constants/app_colors.dart';
import 'package:dollarx/modules/history/cubit/deposit/deposit_history_cubit.dart';
import 'package:dollarx/modules/history/cubit/withdraw/withdraw_history_cubit.dart';
import 'package:dollarx/modules/history/cubit/withdraw/withdraw_history_state.dart';
import 'package:dollarx/modules/history/widget/deposit_history_widget.dart';
import 'package:dollarx/modules/history/widget/withdraw_history_widget.dart';
import 'package:dollarx/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/service_locator.dart';
import '../../../ui/widgets/custom_appbar.dart';
import '../../../ui/widgets/toast_loader.dart';
import '../cubit/deposit/deposit_history_state.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;

  final List<String> items = [
    'Deposit',
    'Withdraw',
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WithdrawHistoryCubit(sl()),
      child: Scaffold(
        appBar: CustomAppbar(
          title: "History",
        ),
        backgroundColor: Colors.black,
        body: BlocConsumer<DepositHistoryCubit, DepositHistoryState>(
          listener: (context, depositState) {
            if (depositState.depositHistoryStatus ==
                DepositHistoryStatus.loading) {
              ToastLoader.show();
            } else if (depositState.depositHistoryStatus ==
                DepositHistoryStatus.success) {
              ToastLoader.remove();
              setState(() {});
            } else if (depositState.depositHistoryStatus ==
                DepositHistoryStatus.error) {
              ToastLoader.remove();
              context.showSnackBar(depositState.message);
            }
          },
          builder: (context, depositState) {
            return BlocConsumer<WithdrawHistoryCubit, WithdrawHistoryState>(
              listener: (context, withdrawState) {
                if (withdrawState.withdrawHistoryStatus ==
                    WithdrawHistoryStatus.loading) {
                  ToastLoader.show();
                } else if (withdrawState.withdrawHistoryStatus ==
                    WithdrawHistoryStatus.success) {
                  ToastLoader.remove();
                  setState(() {});
                } else if (withdrawState.withdrawHistoryStatus ==
                    WithdrawHistoryStatus.error) {
                  ToastLoader.remove();
                  context.showSnackBar(withdrawState.message);
                }
              },
              builder: (context, withdrawState) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      child: Row(
                        children: List.generate(
                          items.length,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                              if (selectedIndex == 0) {
                                context.read<DepositHistoryCubit>()
                                  ..depositHistory();
                              } else if (selectedIndex == 1) {
                                context.read<WithdrawHistoryCubit>()
                                  ..withdrawHistory();
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 12),
                              width: 100,
                              height: 34,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: selectedIndex == index
                                    ? AppColors.secondary
                                    : AppColors.fieldColor,
                              ),
                              child: Center(
                                child: Text(
                                  items[index],
                                  style: context.textTheme.titleSmall?.copyWith(
                                    color: selectedIndex == index
                                        ? Colors.black
                                        : AppColors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: AppColors.grey3.withOpacity(.5),
                      thickness: .2,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Expanded(
                        child: selectedIndex == 0
                            ? ListView.builder(
                                itemCount: depositState
                                    .depositHistoryList.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return DepositHistoryWidget(
                                    depositHistoryModel: depositState
                                        .depositHistoryList[index], onSoldTap: () {  },
                                  );
                                })
                            : ListView.builder(
                                itemCount: withdrawState
                                    .withdrawHistoryList.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return WithdrawHistoryWidget(
                                    withdrawHistoryModel: withdrawState
                                        .withdrawHistoryList[index],
                                  );
                                }))
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
