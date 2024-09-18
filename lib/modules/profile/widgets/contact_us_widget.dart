import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';

class ContactUsWidget extends StatelessWidget {
  final String title;
  final String image;
  final String contact;
  const ContactUsWidget({super.key, required this.title, required this.image, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image, height: 50,width: 50,),
        SizedBox(width: 16,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w300),),
            SizedBox(height: 6,),
            Text(contact,style: context.textTheme.bodyLarge,),
          ],
        )
      ],
    );
  }
}
