

import 'package:dollarx/constants/app_colors.dart';
import 'package:dollarx/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';

class GainerLoserListWidget extends StatefulWidget {
  const GainerLoserListWidget({super.key});

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
            Container(
              padding: EdgeInsets.all(10),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: AppColors.fieldColor,

              ),
              child: Image.asset("assets/images/png/ic_bitcoin.png"),
            ),
            SizedBox(width: 8,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Bitcoin",
                    style: context.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),),
                  Text("BTC \$8,456.90",
                    style: context.textTheme.bodySmall?.copyWith(fontSize: 10,color: AppColors.secondary),)
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("0.125432",
                    style: context.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),),
                  Text("+4.2%",
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
