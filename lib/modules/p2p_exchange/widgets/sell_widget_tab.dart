import 'package:dollarax/config/routes/nav_router.dart';
import 'package:dollarax/core/di/service_locator.dart';
import 'package:dollarax/modules/p2p_exchange/widgets/p2p_sell_widget.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/approve_exchange/approve_exchange_cubit.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/exchange_history/p2p_exchange_history_cubit.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/exchange_history/p2p_exchange_history_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/hold_exchange/hold_exchange_cubit.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/hold_exchange/hold_exchange_state.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_approved_exchange_input.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_exchange_history_response.dart';
import 'package:dollarax/modules/p2p_exchange/pages/p2p_sell_page.dart';
import 'package:dollarax/modules/user/cubits/user_cubit.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:dollarax/ui/widgets/toast_loader.dart';
import 'package:dollarax/utils/display/display_utils.dart';
import 'package:dollarax/utils/extensions/context_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../user/repository/user_account_repository.dart';

class SellWidgetTab extends StatefulWidget {
  const SellWidgetTab({super.key});

  @override
  State<SellWidgetTab> createState() => _SellWidgetTabState();
}

class _SellWidgetTabState extends State<SellWidgetTab> {
  late P2PExchangeModel exchangeModel;
  UserAccountRepository _userAccountRepository = sl<UserAccountRepository>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HoldExchangeCubit, HoldExchangeState>(
      listener: (context, holdState) {
        if (holdState.holdExchangeStatus == HoldExchangeStatus.loading) {
          ToastLoader.show();
        }
        if (holdState.holdExchangeStatus == HoldExchangeStatus.error) {
          ToastLoader.remove();
          DisplayUtils.showToast(context, holdState.message);
        }
        if (holdState.holdExchangeStatus == HoldExchangeStatus.success) {
          ToastLoader.remove();
          DisplayUtils.showToast(context, holdState.message);
          context.read<P2PExchangeHistoryCubit>().p2pSellExchangeHistory();
          // NavRouter.push(context, P2PSellPage(exchangeModel: exchangeModel))
          //     .then((value) {
          //   context.read<P2PExchangeHistoryCubit>().p2pSellExchangeHistory();
          // });
        }
      },
      builder: (context, holdState) {
        return BlocBuilder<P2PExchangeHistoryCubit, P2pExchangeHistoryState>(
            builder: (context, state) {
          if (state.p2pExchangeStatus == P2PExchangeHistoryStatus.loading) {
            return Center(child: LoadingIndicator());
          }
          if (state.p2pExchangeStatus == P2PExchangeHistoryStatus.error) {
            return Center(child: Text(state.message));
          }
          if (state.p2pExchangeStatus == P2PExchangeHistoryStatus.success) {
            return RefreshIndicator(
              child: state.p2pSellExchangeList.isEmpty
                  ? Center(
                      child: Text("No Data Found"),
                    )
                  : ListView.builder(
                      itemCount: state.p2pSellExchangeList.length,
                      itemBuilder: (context, index) {
                        return P2PSellWidget(
                          onSellTap: () {
                            exchangeModel = state.p2pSellExchangeList[index];
                            if (state.p2pSellExchangeList[index]
                                    .exchangeStatus ==
                                'Hold') {
                              if (state.p2pSellExchangeList[index].userId
                                      .toString() ==
                                  _userAccountRepository
                                      .getUserFromDb()
                                      .id
                                      .toString())
                                NavRouter.push(
                                        context,
                                        P2PSellPage(
                                            exchangeModel: exchangeModel))
                                    .then((value) {
                                  context
                                      .read<P2PExchangeHistoryCubit>()
                                      .p2pSellExchangeHistory();
                                });
                            } else if (state.p2pSellExchangeList[index]
                                    .exchangeStatus ==
                                'Processing') {
                              context
                                  .read<ApproveExchangeCubit>()
                                  .p2pApprovedSellExchange(
                                      P2pApprovedExchangeInput(
                                          p2p_id: state
                                              .p2pSellExchangeList[index].id,
                                          status: 'Approved'))
                                  .then((value) {
                                context
                                    .read<P2PExchangeHistoryCubit>()
                                    .p2pSellExchangeHistory();
                              });
                            } else {
                              context.read<HoldExchangeCubit>().p2pHoldSell(
                                  state.p2pSellExchangeList[index].id);
                            }
                          },
                          exchangeModel: state.p2pSellExchangeList[index],
                        );
                      }),
              onRefresh: () {
                return Future.delayed(
                  Duration(seconds: 1),
                  () {
                    context.read<P2PExchangeHistoryCubit>()
                      ..p2pSellExchangeHistory();
                  },
                );
              },
            );
          }
          return EmptyWidget();
        });
      },
    );
  }
}
