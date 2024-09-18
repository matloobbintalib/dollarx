import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/modules/wallet/models/wallet_details_response.dart';
import 'package:dollarax/utils/custom_date_time_picker.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/widgets.dart';

class FeatureBalanceWidget extends StatelessWidget {
  final CurrencyModel currencyModel;

  const FeatureBalanceWidget({super.key, required this.currencyModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Color(0xFF2A2311),
          border: Border.all(color: AppColors.secondary),
          borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16, bottom: 10) +
                EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Feature Balance',
                  style: context.textTheme.bodySmall,
                ),
                Text(
                  '${currencyModel.balanceUsd} USD',
                  style: context.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/png/feature_balance_backgeound.png",
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${currencyModel.balance.toString()} ${currencyModel.currency}',
                        style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.fieldColor,
                          borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.all(6),
                      child: Image.asset(
                        currencyModel.currency == 'USDT'
                            ? "assets/images/png/ic_usdt.png"
                            : currencyModel.currency == 'ETH'
                                ? 'assets/images/png/ic_eth_white.png'
                                : "assets/images/png/ic_bitcoin.png",
                        height: 24,
                        width: 24,
                        color: AppColors.white,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
