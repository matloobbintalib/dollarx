

import 'package:dollarx/constants/app_colors.dart';
import 'package:dollarx/modules/history/models/deposit_history_response.dart';
import 'package:dollarx/ui/widgets/primary_button.dart';
import 'package:dollarx/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DepositHistoryWidget extends StatelessWidget {
  final DepositHistoryModel depositHistoryModel;
  final VoidCallback onSoldTap;
  const DepositHistoryWidget({super.key, required this.depositHistoryModel, required this.onSoldTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12)+EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),color: AppColors.fieldColor
      ),

      child: Row(
          children: [
            Image.asset("assets/images/png/currency_icon.png", width: 40,height: 40,color: AppColors.secondary,),
            SizedBox(width: 10,),
            Expanded(
              flex: 1,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("DAX-00${depositHistoryModel.id}",
                    style: context.textTheme.bodyMedium?.copyWith(color: AppColors.white, fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                  SizedBox(height: 6,),
                  Text(changeDateFormat(depositHistoryModel.createdAt),
                    style: context.textTheme.bodySmall?.copyWith(color: AppColors.white, fontWeight: FontWeight.w300),textAlign: TextAlign.center,),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(roundTwoDecimal(depositHistoryModel.amount) +" "+depositHistoryModel.currency,
                    style: context.textTheme.bodyMedium?.copyWith(color: AppColors.white, fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                  SizedBox(height: 6,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if(depositHistoryModel.status.toLowerCase() == "approved")
                      PrimaryButton(onPressed: onSoldTap, title: 'Sold',width: 50,fontSize: 11,height: 22,titleColor: AppColors.white,borderRadius: 2,),
                      SizedBox(width: 8,),
                      Text(depositHistoryModel.status,
                        style: context.textTheme.bodySmall?.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w300),textAlign: TextAlign.center,),
                    ],
                  )
                ],
              ),
            ),
          ],
      ),
    );
  }

  String roundTwoDecimal(String value){
    double number = double.parse(value);
    return number.toStringAsFixed(2);
  }
  
  String changeDateFormat(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return formattedDate;
  }
}
