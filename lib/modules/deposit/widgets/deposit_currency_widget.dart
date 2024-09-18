

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dollarax/ui/widgets/on_click.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants/app_colors.dart';
import '../models/deposit_data_response.dart';

class DepositCurrencyWidget extends StatefulWidget {
  final String leadingPath ;
  final String title ;
  final InvestmentCurrency investmentCurrency;
  final Function(String value)? onSelect;
  const DepositCurrencyWidget({super.key, required this.leadingPath, required this.investmentCurrency, required this.title, this.onSelect});

  @override
  State<DepositCurrencyWidget> createState() => _DepositCurrencyWidgetState();
}

class _DepositCurrencyWidgetState extends State<DepositCurrencyWidget> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius:
          BorderRadius.all(Radius.circular(6)),
          color: AppColors.fieldColor),
      margin: EdgeInsets.only(bottom: 16
      ),
      child: Column(
        children: [
          OnClick(
            onTap: () {
              setState(() {
                isSelected =!isSelected;
              });
            },
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color:isSelected ?  AppColors.secondary : AppColors.fieldColor),
              padding: EdgeInsets.symmetric(horizontal: 16,),
              child: Row(
                children: [
                  Image.asset(
                    widget.leadingPath,
                    height: 30,
                    width: 30,
                    color: isSelected? Colors.black:AppColors.secondary,
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: context.textTheme.bodySmall?.copyWith(fontSize: 11, color: isSelected? Colors.black : Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Image.asset(
                    "assets/images/png/ic_drop_down_black.png",
                    width: 12,
                    height: 12,
                    color: isSelected? Colors.black:Colors.white,
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible:isSelected ,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 12, top: 8, right: 8, bottom: 8),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30)),
                                child: CachedNetworkImage(
                                  imageUrl:'https://dollarax.com/customer_assets/images/btc.svg'
                                  /*'https://dollarax.com/${widget.investmentCurrency.image}'*/,
                                  placeholder: (context, url) =>
                                  new CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Image.asset(
                                    'assets/images/png/placeholder.jpg',width: 18,
                                    height: 18,),
                                  width: 18,
                                  height: 18,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(
                                  widget.investmentCurrency.symbol.toString() == "usdt" ? "${widget.investmentCurrency.name} Tron (TRC20)" : widget.investmentCurrency.name,
                                  style: context
                                      .textTheme.bodyMedium,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.investmentCurrency.adminAddress,
                            style: context.textTheme.bodySmall
                                ?.copyWith(
                                fontWeight: FontWeight.w400,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 11),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          OnClick(
                            onTap: () {
                              if (widget.onSelect != null) {
                                widget.onSelect!(widget.investmentCurrency.adminAddress);
                              }
                              Clipboard.setData( ClipboardData(text: widget.investmentCurrency.adminAddress)).then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Copied to your clipboard!')));
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(6)),
                                  color: AppColors.secondary),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                      "assets/images/png/ic_copy.png",
                                      height: 18,
                                      width: 18),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "Copy Wallet Address",
                                    style: context
                                        .textTheme.bodySmall
                                        ?.copyWith(
                                        fontWeight:
                                        FontWeight.w400,
                                        fontSize: 11,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  CachedNetworkImage(
                    imageUrl:
                    'https://dollarax.com/newfront_assets/images/${widget.investmentCurrency.name}.png',
                    placeholder: (context, url) =>
                    new CircularProgressIndicator(color: Colors.white,),
                    errorWidget: (context, url, error) => Image.asset(
                      'assets/images/png/placeholder.jpg',width: 100,
                      height: 100,),
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
