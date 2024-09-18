import 'package:dollarax/config/routes/nav_router.dart';
import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/core/di/service_locator.dart';
import 'package:dollarax/modules/p2p_exchange/models/p2p_exchange_history_response.dart';
import 'package:dollarax/modules/p2p_exchange/pages/view_receipt_page.dart';
import 'package:dollarax/modules/user/repository/user_account_repository.dart';
import 'package:dollarax/ui/widgets/on_click.dart';
import 'package:dollarax/ui/widgets/primary_button.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';

class P2PSellWidget extends StatefulWidget {
  final VoidCallback onSellTap;
  final P2PExchangeModel exchangeModel;

  const P2PSellWidget(
      {super.key, required this.onSellTap, required this.exchangeModel});

  @override
  State<P2PSellWidget> createState() => _P2PSellWidgetState();
}

class _P2PSellWidgetState extends State<P2PSellWidget> {
  UserAccountRepository _userAccountRepository = sl<UserAccountRepository>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
        color: AppColors.secondary,
      )),
      margin: EdgeInsets.only(bottom: 10) + EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(10)+EdgeInsets.symmetric(vertical: 16,horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (getReferralID().isNotEmpty)...[
                  Row(
                    children: [
                      Text(
                        getReferralID(),
                        style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppColors.hindColor),
                      ),
                      SizedBox(width: 8,),
                      Text(
                        "(${widget.exchangeModel.user_type})",
                        style: context.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color:  widget.exchangeModel.user_type == 'verified'?Color(0xff185E1B):AppColors.hindColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
                Row(
                  children: [
                    Text(
                      widget.exchangeModel.currencyRate,
                      style: context.textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.exchangeModel.sellCurrency,
                      style: context.textTheme.bodyLarge,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      'Quantity',
                      style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: AppColors.hindColor),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      '${widget.exchangeModel.buyAmount}  ${widget.exchangeModel.buyCurrency}',
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w500, fontSize: 10),
                    ),
                  ],
                ),SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Text(
                      'Amount',
                      style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                          color: AppColors.hindColor),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      '${widget.exchangeModel.sellAmount}  ${widget.exchangeModel.sellCurrency}',
                      style: context.textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w500, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Visibility(
                visible: widget.exchangeModel.exchangeStatus == 'Processing' &&
                    widget.exchangeModel.buyerId.toString() ==
                        _userAccountRepository.getUserFromDb().id.toString(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OnClick(onTap: (){
                      NavRouter.push(
                          context,
                          ViewReceiptPage(
                            imageUrl: widget.exchangeModel.profImage,
                          ));
                    }, child: Text(
                      'View Receipt',
                      style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          decorationColor:Colors.white,
                          decorationThickness: 2,
                          color: AppColors.white),
                    )),
                    SizedBox(height: 6,),
                  ],
                ),
              ),
              Text(
                widget.exchangeModel.bankName,
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: AppColors.hindColor),
              ),
              SizedBox(
                height: 8,
              ),
              Visibility(
                  visible: !buttonVisibilityStatus(),
                  child: Text('Status: ${getBuyerButtonStatusText()}')),
              Visibility(
                visible: buttonVisibilityStatus(),
                child: PrimaryButton(
                  onPressed: widget.onSellTap,
                  title: getButtonStatusText(),
                  width: 80,
                  backgroundColor: Color(0xffA30D0D),
                  height: 26,
                  borderColor:
                      widget.exchangeModel.exchangeStatus == 'Processing'
                          ? Color(0xffA30D0D)
                          : Color(0xffA30D0D),
                  borderRadius: 6,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  titleColor: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  bool buttonVisibilityStatus() {
    print(
        'Local User id : ${_userAccountRepository.getUserFromDb().id.toString()}');
    print('User id : ${widget.exchangeModel.userId.toString()}');
    print('Buyer id : ${widget.exchangeModel.buyerId.toString()}');
    print('Status : ${widget.exchangeModel.exchangeStatus}');
    if (widget.exchangeModel.exchangeStatus == 'New') {
      if (widget.exchangeModel.userId.toString() !=
          _userAccountRepository.getUserFromDb().id.toString()) {
        return true;
      } else {
        return false;
      }
    } else if (widget.exchangeModel.exchangeStatus == 'Hold') {
      if (widget.exchangeModel.userId.toString() ==
          _userAccountRepository.getUserFromDb().id.toString()) {
        return true;
      } else {
        return false;
      }
    } else if (widget.exchangeModel.exchangeStatus == 'Processing') {
      if (widget.exchangeModel.buyerId.toString() ==
          _userAccountRepository.getUserFromDb().id.toString()) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  String getButtonStatusText() {
    if (widget.exchangeModel.exchangeStatus == 'New') {
      return "Sell";
    } else if (widget.exchangeModel.exchangeStatus == 'Hold') {
      return "Payment";
    } else if (widget.exchangeModel.exchangeStatus == 'Processing') {
      return "Approved";
    } else {
      return 'Sell';
    }
  }


  String getBuyerButtonStatusText(){
    if(widget.exchangeModel.exchangeStatus == 'New'){
      return "Sell";
    }else if(widget.exchangeModel.exchangeStatus == 'Hold'){
      return "Hold";
    }else if(widget.exchangeModel.exchangeStatus == 'Processing'){
      return "Processing";
    }else{
      return 'Sell';
    }
  }

  String getReferralID() {
    if (widget.exchangeModel.user_referral_id == null) {
      return '';
    } else {
      return widget.exchangeModel.user_referral_id.toString();
    }
  }
}
