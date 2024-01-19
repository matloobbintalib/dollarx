import 'package:dollarx/modules/referalls/widgets/referral_id_widget.dart';
import 'package:dollarx/modules/referalls/widgets/referral_level_value_widget.dart';
import 'package:dollarx/modules/referalls/widgets/referral_level_widget.dart';
import 'package:dollarx/modules/referalls/widgets/referral_list_widget.dart';
import 'package:dollarx/ui/input/input_field.dart';
import 'package:dollarx/ui/widgets/base_scaffold.dart';
import 'package:dollarx/ui/widgets/custom_appbar.dart';
import 'package:dollarx/ui/widgets/primary_button.dart';
import 'package:dollarx/ui/widgets/search_field.dart';
import 'package:dollarx/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../investment/widgets/investment_widget.dart';

class ReferralsPage extends StatefulWidget {
  const ReferralsPage({super.key});

  @override
  State<ReferralsPage> createState() => _ReferralsPageState();
}

class _ReferralsPageState extends State<ReferralsPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        safeAreaTop: true,
        appBar: CustomAppbar(
          title: 'Referrals',
          backArrow: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              ReferralIDWidget(
                  iconPath: "assets/images/png/ic_referral_id.png",
                  title: "Referral ID",
                  price: "\$25,250.20",
                  suffixIconPath: "assets/images/png/ic_document.png"),
              ReferralIDWidget(
                  iconPath: "assets/images/png/ic_referral_id.png",
                  title: "Parent ID",
                  price: "\$25,250.20"),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Referral Link",
                  style: context.textTheme.bodySmall
                      ?.copyWith(fontWeight: FontWeight.w400, fontSize: 11),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          color: AppColors.onSecondary,
                          border:
                              Border.all(color: AppColors.secondary, width: 1)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "https://dollarax.com/referrals",
                            style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  PrimaryButton(
                    onPressed: () {},
                    title: "Copy Link",
                    titleColor: Colors.black,
                    width: 120,
                    height: 36,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Referrals ",
                    style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: AppColors.secondary),
                  ),
                  Text(
                    "List",
                    style: context.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ReferralLevelValueWidget(value: '\$3443142',),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: ReferralLevelValueWidget(value: '\$3443142',),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: ReferralLevelValueWidget(value: '\$3443142',),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: ReferralLevelValueWidget(value: '\$3443142',),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: ReferralLevelValueWidget(value: '\$3443142',),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ReferralLevelWidget(title: 'First Level', onTap: () {  },),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: ReferralLevelWidget(title: 'Second Level', onTap: () {  },),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: ReferralLevelWidget(title: 'Third Level', onTap: () {  },),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: ReferralLevelWidget(title: 'Fourth Level', onTap: () {  },),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: ReferralLevelWidget(title: 'Fifth Level', onTap: () {  },),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    color: AppColors.onSecondary,
                    border: Border.all(
                      color: AppColors.secondary
                    )
                  ),
                  child: Stack(
                    children: [
                      Container(
                        child: SearchField(
                          controller: searchController,
                          label: 'Search Here...',
                          textInputAction: TextInputAction.done,
                          fillColor: AppColors.onSecondary,
                          borderRadius: 30,
                          edgeInsetsGeometry: EdgeInsets.only(left: 12, top: 7,bottom: 7,right: 40),
                          maxLines: 1,
                        ),
                        margin: EdgeInsets.only(right: 60),
                      ),
                      Positioned(
                        right: 0,
                        child: PrimaryButton(
                          onPressed: () {},
                          title: "Search",
                          titleColor: Colors.black,
                          width: 90,
                          height: 38,
                          fontSize: 12,
                          borderRadius: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                    color: AppColors.secondary
                ),
                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                child:Row(
                  children: [
                    Expanded(
                      child: Text('Sr#',
                        style: context.textTheme.bodySmall?.copyWith(fontSize: 11, color: Colors.black,fontWeight: FontWeight.w600),textAlign: TextAlign.left,),
                    ),
                    SizedBox(width: 8,),
                    Expanded(
                      child: Text("Referrals ID",
                        style: context.textTheme.bodySmall?.copyWith(fontSize: 11, color: Colors.black, fontWeight: FontWeight.w600),),
                    ),
                    SizedBox(width: 8,),
                    Expanded(
                      child: Text("Parent ID",
                        style: context.textTheme.bodySmall?.copyWith(fontSize: 11, color: Colors.black,fontWeight: FontWeight.w600),),
                    ),
                  ],
                ),
              ),
              Column(
                children: List.generate(7, (index) {
                  return ReferralListWidget(index: index,);
                }),
              ),
            ],
          ),
        ));
  }
}
