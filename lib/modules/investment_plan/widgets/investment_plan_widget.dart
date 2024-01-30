import 'package:cached_network_image/cached_network_image.dart';
import 'package:dollarx/constants/app_colors.dart';
import 'package:dollarx/modules/investment_plan/models/investment_plan_response.dart';
import 'package:dollarx/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';

class InvestmentPlanWidget extends StatelessWidget {
  final InvestmentPlanModel investmentPlanModel;
  const InvestmentPlanWidget({super.key, required this.investmentPlanModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.secondary,width: 2)
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 16,right: 20)+EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.secondary
                  ),
                  child: Row(
                    children: [
                      Expanded(child: Text(investmentPlanModel.name, style: context.textTheme.headlineLarge?.copyWith(fontSize: 30),)),
                      CachedNetworkImage(
                        imageUrl:
                        "https://dollarax.com/"+ investmentPlanModel.imgUrl,
                        placeholder: (context, url) =>
                        new CircularProgressIndicator(),
                        errorWidget: (context, url, error) => ClipRRect(
                            borderRadius:
                            BorderRadius.all(Radius.circular(30)),
                            child: Image.asset(
                              'assets/images/png/placeholder.jpg',width: 40,
                              height: 40,)),
                        width: 80,
                        height: 80,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24,),
                Text("Criteria For Join This Plan", style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),),
                SizedBox(height: 16,),
                Row(
                  children: [
                    Text("Personal Investment Must be:", style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),),
                    SizedBox(width: 4,),
                    Text("\$${investmentPlanModel.personelInvestmentLimit}", style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600, color: AppColors.secondary),)
                  ],
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
          Divider(color: AppColors.secondary,thickness: 1,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Referral Bonuses:", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,color: AppColors.secondary),),
                SizedBox(height: 4,),
                Row(
                  children: [

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Affiliate Bonuses", style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),),
                          SizedBox(height: 14,),
                          Row(
                            children: [
                              Expanded(child: Text("Fist Line", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),)),
                              Expanded(child: Text(investmentPlanModel.profitBonus.first.firstPline+"%", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,color: AppColors.secondary),textAlign: TextAlign.center,)),
                            ],
                          ),
                          SizedBox(height: 14,),
                          Row(
                            children: [
                              Expanded(child: Text("Second Line", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),)),
                              Expanded(child: Text(investmentPlanModel.profitBonus.first.secondPline+"%", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,color: AppColors.secondary),textAlign: TextAlign.center,)),
                            ],
                          ),
                          SizedBox(height: 14,),
                          Row(
                            children: [
                              Expanded(child: Text("Third Line", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),)),
                              Expanded(child: Text(investmentPlanModel.profitBonus.first.thirdPline+"%", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,color: AppColors.secondary),textAlign: TextAlign.center,)),
                            ],
                          ),
                          SizedBox(height: 14,),
                          Row(
                            children: [
                              Expanded(child: Text("Fourth Line", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),)),
                              Expanded(child: Text(investmentPlanModel.profitBonus.first.fourthPline+"%", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,color: AppColors.secondary),textAlign: TextAlign.center,)),
                            ],
                          ),
                          SizedBox(height: 14,),
                          Row(
                            children: [
                              Expanded(child: Text("Fifth Line", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),)),
                              Expanded(child: Text(investmentPlanModel.profitBonus.first.fifthPline+"%", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,color: AppColors.secondary),textAlign: TextAlign.center,)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Referral Bonuses", style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),),
                          SizedBox(height: 14,),
                          Row(
                            children: [
                              Expanded(child: Text("Fist Line", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),)),
                              Expanded(child: Text(investmentPlanModel.investmentBonus.first.firstLine+"%", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,color: AppColors.secondary),textAlign: TextAlign.center,)),
                            ],
                          ),
                          SizedBox(height: 14,),
                          Row(
                            children: [
                              Expanded(child: Text("Second Line", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),)),
                              Expanded(child: Text(investmentPlanModel.investmentBonus.first.secondLine+"%", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,color: AppColors.secondary),textAlign: TextAlign.center,)),
                            ],
                          ),
                          SizedBox(height: 14,),
                          Row(
                            children: [
                              Expanded(child: Text("Third Line", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),)),
                              Expanded(child: Text(investmentPlanModel.investmentBonus.first.thirdLine+"%", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,color: AppColors.secondary),textAlign: TextAlign.center,)),
                            ],
                          ),
                          SizedBox(height: 14,),
                          Row(
                            children: [
                              Expanded(child: Text("Fourth Line", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),)),
                              Expanded(child: Text(investmentPlanModel.investmentBonus.first.fourthLine+"%", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,color: AppColors.secondary),textAlign: TextAlign.center,)),
                            ],
                          ),
                          SizedBox(height: 14,),
                          Row(
                            children: [
                              Expanded(child: Text("Fifth Line", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),)),
                              Expanded(child: Text(investmentPlanModel.investmentBonus.first.fifthLine+"%", style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,color: AppColors.secondary),textAlign: TextAlign.center,)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
