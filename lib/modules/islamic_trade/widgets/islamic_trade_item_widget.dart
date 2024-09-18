import 'package:cached_network_image/cached_network_image.dart';
import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/islamic_trade/models/islamic_trade_items_response.dart';
import 'package:dollarax/ui/widgets/primary_button.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IslamicWidgetItemWidget extends StatelessWidget {
  final IslamicTradeItemModel islamicTradeItemModel;
  final VoidCallback onStartTrade;
  const IslamicWidgetItemWidget({super.key, required this.islamicTradeItemModel, required this.onStartTrade});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6,vertical: 8),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondary, width: 1.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          SizedBox(width:6,),
          CachedNetworkImage(
            imageUrl: 'https://dollarax.com/${islamicTradeItemModel.tradeImage}',
            placeholder: (context, url) =>
            new CircularProgressIndicator(),
            errorWidget: (context, url, error) => ClipRRect(
                borderRadius:
                BorderRadius.all(Radius.circular(30)),
                child: Image.asset(
                  'assets/images/png/slider_placeholder.png',
                  width: 45,
                  height: 45,
                )),
            width: 45,
            height: 45,
          ),
          SizedBox(width: 8,),
          Expanded(flex : 1, child: Text(islamicTradeItemModel.title, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: 10),)),
          SizedBox(width: 10,),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(islamicTradeItemModel.monthly_volume_heading, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: 10),),
                SizedBox(height: 4,),
                Text(islamicTradeItemModel.monthlyVolume, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: 10),),
              ],
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(islamicTradeItemModel.returnOfIncome, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: 10),),
                SizedBox(height: 4,),
                Text('${islamicTradeItemModel.tradeProfitPercentage}%', style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: 10,color: AppColors.primaryGreen),),
              ],
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Investors', maxLines:1,style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: 10,overflow: TextOverflow.ellipsis),),
                SizedBox(height: 4,),
                Text(islamicTradeItemModel.investors, style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: 10),),
              ],
            ),
          ),
          SizedBox(width: 10,),
          PrimaryButton(onPressed: onStartTrade, title: 'Copy',fontSize: 10,titleColor: Colors.white,height: 26,width: 60,borderRadius: 30,fontWeight: FontWeight.w800,backgroundColor: AppColors.black,borderColor: AppColors.secondary,)
        ],
      ),
    );
  }
}
