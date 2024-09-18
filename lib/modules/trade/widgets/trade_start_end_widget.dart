import 'package:dollarax/modules/trade/cubit/active_trade/active_trade_cubit.dart';
import 'package:dollarax/modules/trade/cubit/active_trade/active_trade_state.dart';
import 'package:dollarax/modules/trade/cubit/end_trade/end_trade_cubit.dart';
import 'package:dollarax/modules/trade/widgets/end_trade_widget.dart';
import 'package:dollarax/modules/trade/widgets/start_trade_widget.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TradeStartEndWidget extends StatelessWidget {
  final String tradeBtcRate;
  const TradeStartEndWidget({super.key, required this.tradeBtcRate});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveTradeCubit,
        ActiveTradeState>(
      builder: (context, activeTradeState) {
        if (activeTradeState.activeTradeStatus ==
            ActiveTradeStatus.loading) {
          return Center(child: LoadingIndicator());
        }
        if (activeTradeState.activeTradeStatus ==
            ActiveTradeStatus.success) {
          return StartTradeWidget( isTradeStarted: false, tradeBtcRate: tradeBtcRate,);
        }
        if (activeTradeState.activeTradeStatus ==
            ActiveTradeStatus.error) {
          return StartTradeWidget( isTradeStarted: true, tradeBtcRate: tradeBtcRate,);
        }
        return EmptyWidget();
      },
    );
  }
}
