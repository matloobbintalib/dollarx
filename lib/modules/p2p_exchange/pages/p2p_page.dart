import 'package:dollarax/config/routes/nav_router.dart';
import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/core/di/service_locator.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/approve_exchange/approve_exchange_cubit.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/approve_exchange/approve_exchange_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/countries_list/countries_list_cubit.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/countries_list/countries_list_state.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/exchange_history/p2p_exchange_history_cubit.dart';
import 'package:dollarax/modules/p2p_exchange/cubits/hold_exchange/hold_exchange_cubit.dart';
import 'package:dollarax/modules/p2p_exchange/models/countries_list_response.dart';
import 'package:dollarax/modules/p2p_exchange/pages/buy_post_ad_page.dart';
import 'package:dollarax/modules/p2p_exchange/pages/sell_post_ad_page.dart';
import 'package:dollarax/modules/p2p_exchange/widgets/buy_widget_tab.dart';
import 'package:dollarax/modules/p2p_exchange/widgets/sell_widget_tab.dart';
import 'package:dollarax/ui/dialogs/country_dialog.dart';
import 'package:dollarax/ui/widgets/empty_widget.dart';
import 'package:dollarax/ui/widgets/on_click.dart';
import 'package:dollarax/ui/widgets/toast_loader.dart';
import 'package:dollarax/utils/display/display_utils.dart';
import 'package:dollarax/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class P2PPage extends StatefulWidget {
  const P2PPage({super.key});

  @override
  State<P2PPage> createState() => _P2PPageState();
}

class _P2PPageState extends State<P2PPage> {
  int selectedIndex = 0;
  String countryName = "GBP";
  @override
  void initState() {
    super.initState();
    context.read<P2PExchangeHistoryCubit>()..p2pBuyExchangeHistory();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.secondary,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.light,
    ));
    return MultiBlocProvider(
  providers: [
    BlocProvider(
      create: (context) => HoldExchangeCubit(sl()),
),
    BlocProvider(
      create: (context) => ApproveExchangeCubit(sl()),
    ),BlocProvider(
      create: (context) => CountriesListCubit(sl())..getAllCountries()
    ),
  ],
  child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.secondary,
            leading: IconButton(
              icon: Image.asset(
                "assets/images/png/ic_back_arrow.png",
                width: 26,
              ),
              onPressed: () {
                NavRouter.pop(context);
              },
            ),
            title: Text(
              'P2P',
              style: context.textTheme.titleLarge
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            actions: [
              BlocBuilder<CountriesListCubit, CountriesListState>(
                builder: (context, countriesState) {
                  if (countriesState.countriesListStatus ==
                      CountriesListStatus.loading) {
                    return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: IconButton(
                          icon: Image.asset(
                            "assets/images/png/ic_gbp.png",
                            height: 26,
                            width: 75,
                          ),
                          onPressed: () {},
                        ));
                  }
                  if (countriesState.countriesListStatus ==
                      CountriesListStatus.error) {
                    return Center(
                      child: Text(countriesState.message,overflow: TextOverflow.ellipsis,),
                    );
                  }
                  if (countriesState.countriesListStatus ==
                      CountriesListStatus.success) {
                    return IconButton(
                      icon: Container(
                        padding: EdgeInsets.symmetric(vertical: 4,horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black)
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(countryName,style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700,color: Colors.black),),SizedBox(width: 8,),
                            Image.asset("assets/images/png/gbp_icon.png",width: 18,height: 18,)
                          ],
                        ),
                      ),
                      onPressed: () {
                        showDialog(context: context, builder: (BuildContext context){
                          return CountryDialog( countries: countriesState.countriesList
                              .map((e) => e.currency)
                              .toList(), onSelect: (value ) {
                            CountryListModel countryModel = countriesState.countriesList
                                .firstWhere((element) => element.currency == value);
                            countryName = countryModel.currency;
                            setState(() {

                            });
                            if(selectedIndex == 0) {
                              context.read<P2PExchangeHistoryCubit>()..p2pBuyExchangeHistory(currency: countryName);
                            }else{
                              context.read<P2PExchangeHistoryCubit>()..p2pSellExchangeHistory(currency: countryName);
                            }
                          },);
                        });
                      },
                    );
                  }
                  return EmptyWidget();
                },
              ),
              SizedBox(
                width: 8,
              )
            ],
          ),
          backgroundColor: AppColors.secondary,
          body: BlocConsumer<ApproveExchangeCubit, ApproveExchangeState>(
            listener: (context, approveState) {
              if (approveState.approveExchangeStatus ==
                  ApproveExchangeStatus.loading) {
                ToastLoader.show();
              }
              if (approveState.approveExchangeStatus ==
                  ApproveExchangeStatus.error) {
                ToastLoader.remove();
                DisplayUtils.showToast(context, approveState.message);
              }
              if (approveState.approveExchangeStatus ==
                  ApproveExchangeStatus.success) {
                ToastLoader.remove();
                context.read<P2PExchangeHistoryCubit>()..p2pBuyExchangeHistory();
                context.read<P2PExchangeHistoryCubit>()..p2pSellExchangeHistory();
              }
            },
            builder: (context, approveState) {
              return Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 26,
                          margin: EdgeInsets.only(left: 20),
                          width: 110,
                          child: Row(
                            children: [
                              Expanded(
                                  child: OnClick(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 0;
                                  });
                                  context.read<P2PExchangeHistoryCubit>()
                                    ..p2pBuyExchangeHistory();
                                },
                                child: Container(
                                  height: 26,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: selectedIndex == 0
                                          ? AppColors.secondary
                                          : Colors.black,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          color: AppColors.secondary,
                                          width: 1.5)),
                                  child: Text(
                                    'Buy',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ),
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: OnClick(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = 1;
                                  });
                                  context.read<P2PExchangeHistoryCubit>()
                                    ..p2pSellExchangeHistory();
                                },
                                child: Container(
                                  height: 26,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: selectedIndex == 1
                                          ? AppColors.secondary
                                          : Colors.black,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          color: AppColors.secondary,
                                          width: 1.5)),
                                  child: Text(
                                    'Sell',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ),
                              ))
                            ],
                          ),
                        ),
                        Spacer(),
                        OnClick(
                          onTap: () {
                            if (selectedIndex == 0) {
                              NavRouter.push(context, BuyPostAdPage());
                            } else {
                              NavRouter.push(context, SellPostAdPage());
                            }
                          },
                          child: Container(
                            height: 26,
                            width: 75,
                            margin: EdgeInsets.only(right: 16),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: AppColors.secondary, width: 1.5)),
                            child: Text(
                              'Post ad',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 12),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: AppColors.secondary,
                      height: 30,
                    ),
                    Expanded(
                        child: selectedIndex == 0
                            ? BuyWidgetTab()
                            : SellWidgetTab())
                  ],
                ),
              );
            },
          ),
        ),
      ),
);
  }
}
