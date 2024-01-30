import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'loading_indicator.dart';

class CircularCachedImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final String errorPath;

  const CircularCachedImage({super.key, 
    required this.imageUrl,
    this.width = 280,
    this.height = 280,
    this.fit = BoxFit.cover,
    this.errorPath =  'assets/images/png/placeholder.jpg',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,

      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => const Center(child: LoadingIndicator(),),
        imageBuilder: (context, imageProvider) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider, fit: BoxFit.cover,),
          ),
        ),
        errorWidget: (context, url, error) =>  Center(
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: AssetImage(
                      errorPath),
                  fit: BoxFit.cover,
                ),
              ),
            )),
        fit: fit,
      ),
    );
  }
}
