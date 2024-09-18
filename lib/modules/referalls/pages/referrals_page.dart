import 'package:dollarax/modules/referalls/cubit/referral_cubit.dart';
import 'package:dollarax/modules/referalls/cubit/referral_state.dart';
import 'package:dollarax/modules/referalls/widgets/referral_id_widget.dart';
import 'package:dollarax/modules/referalls/widgets/referral_level_value_widget.dart';
import 'package:dollarax/modules/referalls/widgets/referral_level_widget.dart';
import 'package:dollarax/modules/referalls/widgets/referral_list_widget.dart';
import 'package:dollarax/ui/widgets/base_scaffold.dart';
import 'package:dollarax/ui/widgets/custom_appbar.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/loading_indicator.dart';
import 'package:dollarax/ui/widgets/primary_button.dart';
import 'package:dollarax/ui/widgets/search_field.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/app_colors.dart';
import '../../../core/di/service_locator.dart';

import '../models/referral_response.dart';

class ReferralsPage extends StatefulWidget {
  final bool isFromDashboard;

  const ReferralsPage({super.key, required this.isFromDashboard});

  @override
  State<ReferralsPage> createState() => _ReferralsPageState();
}

class _ReferralsPageState extends State<ReferralsPage> {
  TextEditingController searchController = TextEditingController();
  List<LevelReferral> referralLevelList = [];
  bool isDataLoaded = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReferralCubit(sl())..referralData(),
      child: BaseScaffold(
          safeAreaTop: true,
          appBar: CustomAppbar(
            title: 'Referrals',
            backArrow: !widget.isFromDashboard,
          ),
          body: BlocBuilder<ReferralCubit, ReferralState>(
            builder: (context, state) {
              if (state.referralStatus == ReferralStatus.loading) {
                return Center(
                  child: LoadingIndicator(),
                );
              }
              if (state.referralStatus == ReferralStatus.success) {
                if (isDataLoaded) {
                  referralLevelList.clear();
                  referralLevelList
                      .addAll(state.referralModel!.level1Referrals);
                }
                isDataLoaded = false;
                return RefreshIndicator(
                  onRefresh: (){
                    return Future.delayed(
                      Duration(seconds: 1),
                          () {
                        context.read<ReferralCubit>().referralData();
                      },
                    );
                  },
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        ReferralIDWidget(
                            iconPath: "assets/images/png/ic_referral_id.png",
                            title: "Referral ID",
                            price: state.referralModel!.userReferralId,
                            suffixIconPath: "assets/images/png/ic_document.png"),
                        ReferralIDWidget(
                            iconPath: "assets/images/png/ic_referral_id.png",
                            title: "Parent ID",
                            price: state.referralModel!.parentId != null
                                ? state.referralModel!.parentId.toString()
                                : ""),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "Referral Link",
                            style: context.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w400, fontSize: 11),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)),
                                    color: AppColors.onSecondary,
                                    border: Border.all(
                                        color: AppColors.secondary, width: 1)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "https://dollarax.com/referrals",
                                      style: context.textTheme.bodySmall
                                          ?.copyWith(
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
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                        text: "https://dollarax.com/referrals"))
                                    .then((_) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Copied to your clipboard!')));
                                });
                              },
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
                              style: context.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 18),
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
                              child: ReferralLevelValueWidget(
                                value: state.referralModel!.firstLevelInvestment,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: ReferralLevelValueWidget(
                                value: state.referralModel!.secondLevelInvestment,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: ReferralLevelValueWidget(
                                value: state.referralModel!.thirdLevelInvestment,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: ReferralLevelValueWidget(
                                value: state.referralModel!.fourthLevelInvestment,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: ReferralLevelValueWidget(
                                value: state.referralModel!.fifthLevelInvestment,
                              ),
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
                              child: ReferralLevelWidget(
                                title: 'First Level',
                                onTap: () {
                                  context.read<ReferralCubit>()
                                    ..setReferralList(
                                        state.referralModel!.level1Referrals);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: ReferralLevelWidget(
                                title: 'Second Level',
                                onTap: () {
                                  context.read<ReferralCubit>()
                                    ..setReferralList(
                                        state.referralModel!.level2Referrals);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: ReferralLevelWidget(
                                title: 'Third Level',
                                onTap: () {
                                  context.read<ReferralCubit>()
                                    ..setReferralList(
                                        state.referralModel!.level3Referrals);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: ReferralLevelWidget(
                                title: 'Fourth Level',
                                onTap: () {
                                  context.read<ReferralCubit>()
                                    ..setReferralList(
                                        state.referralModel!.level4Referrals);
                                },
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Expanded(
                              child: ReferralLevelWidget(
                                title: 'Fifth Level',
                                onTap: () {
                                  context.read<ReferralCubit>()
                                    ..setReferralList(
                                        state.referralModel!.level5Referrals);
                                },
                              ),
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
                                border: Border.all(color: AppColors.secondary)),
                            child: Stack(
                              children: [
                                Container(
                                  child: SearchField(
                                    controller: searchController,
                                    label: 'Search Here...',
                                    textInputAction: TextInputAction.done,
                                    fillColor: AppColors.onSecondary,
                                    borderRadius: 30,
                                    edgeInsetsGeometry: EdgeInsets.only(
                                        left: 12, top: 7, bottom: 7, right: 40),
                                    maxLines: 1,
                                    onChange: (value) {
                                      if (value.isEmpty) {
                                        context.read<ReferralCubit>()
                                          ..filterSearchResults(value);
                                      }
                                    },
                                  ),
                                  margin: EdgeInsets.only(right: 60),
                                ),
                                Positioned(
                                  right: 0,
                                  child: PrimaryButton(
                                    onPressed: () {
                                      context.read<ReferralCubit>()
                                        ..filterSearchResults(
                                            searchController.text.trim());
                                    },
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
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                              color: AppColors.secondary),
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Sr#',
                                  style: context.textTheme.bodySmall?.copyWith(
                                      fontSize: 11,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  "Referrals ID",
                                  style: context.textTheme.bodySmall?.copyWith(
                                      fontSize: 11,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  "Parent ID",
                                  style: context.textTheme.bodySmall?.copyWith(
                                      fontSize: 11,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children:
                              List.generate(state.levelReferrals.length, (index) {
                            return ReferralListWidget(
                              index: index,
                              levelReferral: state.levelReferrals[index],
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                );
              }
              if (state.referralStatus == ReferralStatus.error) {
                return Center(
                  child: Text(
                    state.message,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              return EmptyWidget();
            },
          )),
    );
  }
}
