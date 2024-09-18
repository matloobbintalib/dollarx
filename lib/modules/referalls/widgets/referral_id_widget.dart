

import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReferralIDWidget extends StatelessWidget {
  final String iconPath;
  final String? suffixIconPath;
  final String title;
  final String price;
  const ReferralIDWidget({super.key, required this.iconPath, required this.title, required this.price,  this.suffixIconPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin:  EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: AppColors.fieldColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child:Row(
                  children: [
                    Image.asset(iconPath, width: 34,height: 34,color: AppColors.secondary,),
                    SizedBox(width: 8,),
                    Text(title,
                      style: context.textTheme.bodySmall?.copyWith(fontSize: 11),),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 30,
                color: AppColors.grey3,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),topRight: Radius.circular(6)),
                    color: AppColors.lightChocolateColor,
                    border: Border(
                      top: BorderSide(color: AppColors.secondary, width: 1.5),
                      bottom: BorderSide(color: AppColors.secondary, width: 1.5),
                      right: BorderSide(color: AppColors.secondary, width: 1.5)
                    )
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(price,
                          style: context.textTheme.bodyLarge?.copyWith(fontSize: 16,overflow: TextOverflow.ellipsis), maxLines: 1,),
                      ),
                      if(suffixIconPath != null && suffixIconPath.toString().isNotEmpty)
                        Image.asset(suffixIconPath.toString(), width: 24,height: 24,)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
