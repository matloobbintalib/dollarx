import 'package:dollarax/modules/wallet/models/wallet_details_response.dart';
import 'package:dollarax/ui/widgets/profile_picture_widget.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';

class RecentPayeeWidget extends StatelessWidget {
  final RecentFundReceiver fundReceiver;

  const RecentPayeeWidget({super.key, required this.fundReceiver});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfilePictureWidget(
            profileUrl: fundReceiver.profilePic != null &&
                    fundReceiver.profilePic.toString().isNotEmpty
                ? "https://dollarax.com/${fundReceiver.profilePic}"
                : "assets/images/png/placeholder.jpg",
            onTap: () {},
            height: 40,
            width: 40,
            showEditIcon: false,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${fundReceiver.fundReceiverReferralId}  (DollarAx ID)',
                style: context.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w400, fontSize: 15),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                fundReceiver.fundReceiverName,
                style: context.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w400, fontSize: 10),
              ),
            ],
          )
        ],
      ),
    );
  }
}
