

import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/home/models/dashoboard_data_response.dart';
import 'package:dollarax/modules/trade/models/active_trade_response.dart';
import 'package:dollarax/utils/custom_date_time_picker.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';

class LatestWithdrawalsWidget extends StatefulWidget {
  final List<LatestWithdrawal> list;
  const LatestWithdrawalsWidget({super.key ,required this.list});

  @override
  State<LatestWithdrawalsWidget> createState() => _LatestWithdrawalsWidgetState();
}

class _LatestWithdrawalsWidgetState extends State<LatestWithdrawalsWidget> {
  final listScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    listScrollController.addListener(listenScrollingList);
  }
  void scrollUpList() {
    final double start = 0;
    listScrollController.jumpTo(start);
    scrollDownList();
  }
  void scrollDownList() {
    final double end = listScrollController.position.maxScrollExtent;
    listScrollController.animateTo(
        end, duration: Duration(seconds: 4), curve: Curves.easeIn);
  }
  void listenScrollingList() {
    if (listScrollController.position.atEdge) {
      final isTop = listScrollController.position.pixels == 0;
      if (isTop) {
        scrollDownList();
      } else {
        scrollUpList();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) {
      scrollDownList();
    });
    return Container(
      height: 16,
      child: ListView.builder(
          controller: listScrollController,
          itemCount: widget.list.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.list[index].user.referralId,
                  style: context.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w700,color: AppColors.secondary),),
                Text('${widget.list[index].amount} USD',
                  style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700),)
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
                  Text(widget.list[index].withdrawType,
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
