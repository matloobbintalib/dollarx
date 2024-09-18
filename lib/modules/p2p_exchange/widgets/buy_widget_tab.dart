import 'package:dollarax/config/config.dart';
import 'package:dollarax/core/di/service_locator.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/approve_exchange/approve_exchange_cubit.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/exchange_history/p2p_exchange_history_cubit.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/exchange_history/p2p_exchange_history_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/hold_exchange/hold_exchange_cubit.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/hold_exchange/hold_exchange_state.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_approved_exchange_input.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_exchange_history_response.dart';
import 'package:dollarax/modules/p2p_exchange/pages/p2p_buy_page.dart';
import 'package:dollarax/modules/p2p_exchange/widgets/p2p_buy_widget.dart';
import 'package:dollarax/modules/user/repository/user_account_repository.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:dollarax/ui/widgets/toast_loader.dart';
import 'package:dollarax/utils/display/display_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyWidgetTab extends StatefulWidget {
  const BuyWidgetTab({super.key});

  @override
  State<BuyWidgetTab> createState() => _BuyWidgetTabState();
}

class _BuyWidgetTabState extends State<BuyWidgetTab> {
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
          NavRouter.push(context, P2PBuyPage(exchangeModel: exchangeModel))
              .then((value) {
            context.read<P2PExchangeHistoryCubit>().p2pBuyExchangeHistory();
          });
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
              child: state.p2pExchangeList.isEmpty
                  ? Center(
                      child: Text("No Data Found"),
                    )
                  : ListView.builder(
                      itemCount: state.p2pExchangeList.length,
                      itemBuilder: (context, index) {
                        return P2PBuyWidget(
                          onBuyTap: () {
                            exchangeModel = state.p2pExchangeList[index];
                            if (state.p2pExchangeList[index].exchangeStatus ==
                                    'Hold' &&
                                _userAccountRepository
                                        .getUserFromDb()
                                        .id
                                        .toString() !=
                                    state.p2pExchangeList[index].userId
                                        .toString()) {
                              NavRouter.push(context,
                                      P2PBuyPage(exchangeModel: exchangeModel))
                                  .then((value) {
                                context
                                    .read<P2PExchangeHistoryCubit>()
                                    .p2pBuyExchangeHistory();
                              });
                            } else if (state
                                    .p2pExchangeList[index].exchangeStatus ==
                                'Processing') {
                              context
                                  .read<ApproveExchangeCubit>()
                                  .p2pApprovedBuyExchange(
                                      P2pApprovedExchangeInput(
                                          p2p_id: state
                                              .p2pExchangeList[index].id,
                                          status: 'Approved'))
                                  .then((value) {
                                context
                                    .read<P2PExchangeHistoryCubit>()
                                    .p2pSellExchangeHistory();
                              });
                            } else {
                              context
                                  .read<HoldExchangeCubit>()
                                  .p2pHoldBuy(state.p2pExchangeList[index].id);
                            }
                          },
                          exchangeModel: state.p2pExchangeList[index],
                        );
                      }),
              onRefresh: () {
                return Future.delayed(
                  Duration(seconds: 1),
                  () {
                    context.read<P2PExchangeHistoryCubit>()
                      ..p2pBuyExchangeHistory();
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
