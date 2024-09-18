

import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/trade/models/active_trade_response.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';

class GainerLoserListWidget extends StatefulWidget {
  final int index;
  final ActiveTrades trade;
  const GainerLoserListWidget({super.key, required this.index, required this.trade});

  @override
  State<GainerLoserListWidget> createState() => _GainerLoserListWidgetState();
}

class _GainerLoserListWidgetState extends State<GainerLoserListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   padding: EdgeInsets.all(10),
            //   height: 50,
            //   width: 50,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(8)),
            //       color: AppColors.fieldColor,
            //
            //   ),
            //   child: Image.asset("assets/images/png/ic_bitcoin.png"),
            // ),
            // SizedBox(width: 8,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('DollarAx coin',
                    style: context.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),),
                  Text("BTC \$${widget.trade.tradeAmount}",
                    style: context.textTheme.bodySmall?.copyWith(fontSize: 10,color: AppColors.secondary),)
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(widget.trade.finalAmount.toString(),
                    style: context.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),),
                  Text(widget.trade.tradeType,
                    style: context.textTheme.bodySmall?.copyWith(fontSize: 10,color: AppColors.lightGreen),)
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 16,)
      ],
    );
  }
}
