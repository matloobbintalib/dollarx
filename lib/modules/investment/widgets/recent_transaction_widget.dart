

import 'package:dollarx/constants/app_colors.dart';
import 'package:dollarx/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/investment_response.dart';
import '../models/recent_transaction_model.dart';

class RecentTransactionWidget extends StatelessWidget {
  final LatestTransDatum latestTransDatum;
  final String iconPath;
  const RecentTransactionWidget({super.key, required this.latestTransDatum, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.symmetric(horizontal: 6,vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: AppColors.fieldColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child:Column(
                  children: [
                    Row(
                      children: [
                        Text("Type : ",
                          style: context.textTheme.bodySmall?.copyWith(color: AppColors.white, fontWeight: FontWeight.w300, fontSize: 11),textAlign: TextAlign.center,),
                        Text(latestTransDatum.type,
                          style: context.textTheme.bodySmall?.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w300, fontSize: 11),textAlign: TextAlign.center,),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Price : ",
                          style: context.textTheme.bodySmall?.copyWith(color: AppColors.white, fontWeight: FontWeight.w300, fontSize: 11),textAlign: TextAlign.center,),
                        Text(latestTransDatum.totalAmount+" USTD",
                          style: context.textTheme.bodySmall?.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w300, fontSize: 11),textAlign: TextAlign.center,),
                      ],
                    ),
                  ],
                ),
              ),
              Image.asset(iconPath, width: 36,height: 36,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(latestTransDatum.createdAt,
                      style: context.textTheme.bodySmall?.copyWith(color: AppColors.white, fontWeight: FontWeight.w300, fontSize: 11)),
                    Text(latestTransDatum.status,
                      style: context.textTheme.bodyMedium?.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w300))
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
