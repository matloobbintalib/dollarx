
import 'package:dollarax/constants/app_colors.dart';
import 'package:dollarax/ui/widgets/on_click.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletIconWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onTab;
  const WalletIconWidget({super.key, required this.iconPath, required this.title, required this.onTab});

  @override
  Widget build(BuildContext context) {
    return OnClick(
      onTap: onTab,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.fieldColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.secondary)
            ),
            child: Image.asset(iconPath,height: 40,width: 40,),
          ),
          Text(title,style: context.textTheme.bodySmall?.copyWith(color: AppColors.black, fontWeight: FontWeight.w500),)
        ],
      ),
    );
  }
}
