import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/ui/input/input_field.dart';
import 'package:dollarax/ui/widgets/primary_button.dart';
import 'package:dollarax/utils/utils.dart';
import 'package:flutter/material.dart';

class TakeProfitStopLossDialog extends StatefulWidget {
  final Function(String takeProfitValue, String stopLossValue) onSubmit;
  const TakeProfitStopLossDialog({super.key, required this.onSubmit});

  @override
  State<TakeProfitStopLossDialog> createState() =>
      _TakeProfitStopLossDialogState();
}

class _TakeProfitStopLossDialogState extends State<TakeProfitStopLossDialog> {
  TextEditingController takeProfitController = TextEditingController();
  TextEditingController stopLossController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xFF1f2630),
        ),
        height: 320,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Take Profit',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(
                height: 6,
              ),
              InputField(
                  controller: takeProfitController,
                  label: 'Price',
                  borderRadius: 0,
                  keyboardType:TextInputType.number,
                  vPadding: 16,
                  fillColor: AppColors.fieldColor,
                  borderColor: AppColors.fieldColor,
                  textInputAction: TextInputAction.done),
              SizedBox(
                height: 10,
              ),
              Text('Stop Loss',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  )),
              SizedBox(
                height: 6,
              ),
              InputField(
                  controller: stopLossController,
                  label: 'Price',
                  borderRadius: 0,
                  keyboardType:TextInputType.number,
                  vPadding: 16,
                  fillColor: AppColors.fieldColor,
                  borderColor: AppColors.fieldColor,
                  textInputAction: TextInputAction.done),
              SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.center,
                child: PrimaryButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      widget.onSubmit(takeProfitController.text.trim(),stopLossController.text.trim());
                    }
                  },
                  title: 'TP/ SL',
                  fontSize: 12,
                  backgroundColor: AppColors.grey,
                  borderColor: AppColors.grey,
                  height: 40,
                  width: 150,
                  titleColor: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
