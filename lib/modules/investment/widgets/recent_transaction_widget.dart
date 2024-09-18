

import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/investment_response.dart';

class RecentTransactionWidget extends StatelessWidget {
  final LatestTransDatum latestTransDatum;
  final String iconPath;
  const RecentTransactionWidget({super.key, required this.latestTransDatum, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: AppColors.secondary)
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text("Type : ",
                style: context.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w500,fontSize: 11),textAlign: TextAlign.center,),
              Text(latestTransDatum.type,
                style: context.textTheme.bodySmall?.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w500, fontSize: 11),textAlign: TextAlign.center,),
              Spacer(),
              Text(latestTransDatum.createdAt.split(' ').first,
                  style: context.textTheme.bodySmall?.copyWith(color: AppColors.white, fontWeight: FontWeight.w300, fontSize: 11)),
            ],
          ),
          SizedBox(height: 4,),
          Row(
            children: [
              Text("Amount : ",
                style: context.textTheme.bodySmall?.copyWith(color: AppColors.white, fontWeight: FontWeight.w300, fontSize: 11),textAlign: TextAlign.center,),
              Text(latestTransDatum.totalAmount+" USD",
                style: context.textTheme.bodySmall?.copyWith(color: AppColors.white, fontWeight: FontWeight.w300, fontSize: 11),textAlign: TextAlign.center,),
              Spacer(),
              Text(latestTransDatum.status,
                  style: context.textTheme.bodyMedium?.copyWith(color: AppColors.white, fontWeight: FontWeight.w300,fontSize: 13))
            ],
          ),
        ],
      ),
    );
  }


}
