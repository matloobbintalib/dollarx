import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/home/models/home_assets_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeAssetsWidget extends StatelessWidget {
  final HomeAssetsModel homeAssetsModel;
  const HomeAssetsWidget({super.key, required this.homeAssetsModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppColors.secondary,)
      ),
      child: Row(
        children: [
          Image.asset(homeAssetsModel.iconPath, height: 34,width: 34 ),
          SizedBox(width: 12),
          Text(
            homeAssetsModel.title,
            style: TextStyle(
              color: AppColors.secondary,fontWeight: FontWeight.w400,fontSize: 13)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
                '${homeAssetsModel.amount} USD',
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.white,fontWeight: FontWeight.w400),textAlign: TextAlign.end,),
          )
        ],
      ),
    );
  }
}
