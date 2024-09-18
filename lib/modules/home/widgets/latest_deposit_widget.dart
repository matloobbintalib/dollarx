

import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/home/models/dashoboard_data_response.dart';
import 'package:dollarax/modules/trade/models/active_trade_response.dart';
import 'package:dollarax/utils/custom_date_time_picker.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';

class LatestDepositWidget extends StatefulWidget {
  final List<LatestDeposit> list;
  const LatestDepositWidget({super.key,  required this.list});

  @override
  State<LatestDepositWidget> createState() => _LatestDepositWidgetState();
}

class _LatestDepositWidgetState extends State<LatestDepositWidget> {
  final depositListController = ScrollController();

  @override
  void initState() {
    super.initState();
    depositListController.addListener(listenScrollingList);
  }
  void scrollUpDepositList() {
    final double start = 0;
    depositListController.jumpTo(start);
    scrollDownDepositList();
  }
  void scrollDownDepositList() {
    final double end = depositListController.position.maxScrollExtent;
    depositListController.animateTo(
        end, duration: Duration(seconds: 4), curve: Curves.easeIn);
  }
  void listenScrollingList() {
    if (depositListController.position.atEdge) {
      final isTop = depositListController.position.pixels == 0;
      if (isTop) {
        scrollDownDepositList();
      } else {
        scrollUpDepositList();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      scrollDownDepositList();
    });
    return Container(
      height: 16,
      child: ListView.builder(
          controller: depositListController,
          itemCount: widget.list.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.list[index].user.referralId,
                  style: context.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w700,color: AppColors.secondary),),
                Text('${widget.list[index].amount} USD',
                  style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700
                  ),)
                /*Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.list[index].amount,
                        style: context.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),),
                      Text(widget.list[index].currency,
                        style: context.textTheme.bodySmall?.copyWith(fontSize: 10,color: AppColors.secondary),)
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(changeDateTimeFormat1(widget.list[index].createdAt, 'yyyy-MM-dd'),
                        style: context.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),),
                      Text(widget.list[index].depositType,
                        style: context.textTheme.bodySmall?.copyWith(fontSize: 10,color: AppColors.lightGreen),)
                    ],
                  ),
                )*/
              ],
            );
          }),
    );
  }
}
