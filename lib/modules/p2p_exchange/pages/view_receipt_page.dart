import 'package:cached_network_image/cached_network_image.dart';
import 'package:dollarax/ui/widgets/custom_appbar.dart';
import 'package:dollarax/ui/widgets/profile_picture_widget.dart';
import 'package:flutter/material.dart';

class ViewReceiptPage extends StatelessWidget {
  final String imageUrl;

  const ViewReceiptPage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'View Receipt',
      ),
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(20),
        child: CachedNetworkImage(
          imageUrl: imageUrl.isNotEmpty? "https://dollarax.com/"+imageUrl
              : "assets/images/png/placeholder.jpg",
          placeholder: (context, url) => SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/png/placeholder.jpg',
                  width: double.infinity,
                ),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          ),
          errorWidget: (context, url, error) => ClipRRect(
            child: Image.asset(
              'assets/images/png/placeholder.jpg',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
