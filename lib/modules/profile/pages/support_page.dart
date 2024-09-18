import 'package:dollarax/modules/profile/widgets/contact_us_widget.dart';
import 'package:dollarax/ui/widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "Support",
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ContactUsWidget(title: "Contact Us On Whatsapp", image: "assets/images/png/whatsapp.png", contact: '+17372811724'),
            SizedBox(height: 30,),
            ContactUsWidget(title: 'Send Email', image: "assets/images/png/gmail.png", contact: 'support@dollarax.com')
          ],
        ),
      ),
    );
  }
}
