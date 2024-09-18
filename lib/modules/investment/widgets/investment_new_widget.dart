

import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/ui/widgets/on_click.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InvestmentNewWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final String price;
  final VoidCallback onTap;
  const InvestmentNewWidget({super.key, required this.iconPath, required this.title, required this.price,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return OnClick(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: EdgeInsets.only(left: 8),
        margin:  EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          border: Border.all(color: AppColors.secondary)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child:Row(
                children: [
                  Image.asset(iconPath, width: 30,height: 30,color: AppColors.secondary,),
                  SizedBox(width: 8,),
                  Text(title,
                    style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w300,fontSize: 11),),
                ],
              ),
            ),
            Container(
              width: 7,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.secondary)
              ),
            ),
            Expanded(
              child: Text(price,
                style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400,fontSize: 13),textAlign: TextAlign.center,),
            )
          ],
        ),
      ),
    );
  }
}
