import 'package:dollarax/modules/p2p_exchange/cubits/buy_post_ad_cubit.dart';
import 'package:dollarax/modules/trade/cubit/active_trade/active_trade_cubit.dart';
import 'package:dollarax/modules/trade/cubit/gold_live_data/gold_live_data_cubit.dart';
import 'package:dollarax/modules/trade/cubit/gold_rate/gold_rate_cubit.dart';
import 'package:dollarax/modules/trade/cubit/gold_trade/gold_trade_cubit.dart';
import 'package:dollarax/modules/user/cubits/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/core.dart';
import '../modules/p2p_exchange/cubits/exchange_history/p2p_exchange_history_cubit.dart';

class BlocDI extends StatelessWidget {
  const BlocDI({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(create: (context) => UserCubit(userAccountRepository: sl())),
        BlocProvider<ActiveTradeCubit>(create: (context) => ActiveTradeCubit(sl())),
        BlocProvider<GoldTradeCubit>(create: (context) => GoldTradeCubit(sl())),
        BlocProvider<GoldRateCubit>(create: (context) => GoldRateCubit(sl())),
        BlocProvider<P2PExchangeHistoryCubit>(create: (context) => P2PExchangeHistoryCubit(sl())),
        BlocProvider<BuyPostAdCubit>(create: (context) => BuyPostAdCubit()),
        BlocProvider<GoldLiveDataCubit>(create: (context) => GoldLiveDataCubit()),
      ],
      child: child,
    );
  }
}