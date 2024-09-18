import 'dart:io';

import 'package:dollarax/utils/extensions/extended_context.dart';
import 'package:flutter/material.dart';
import 'circular_cached_image.dart';

class ProfilePictureWidget extends StatelessWidget {
  final String profileUrl;
  final VoidCallback onTap;
  final double width ;
  final double height;
  final bool showEditIcon;
  final double borderRadius;

  const ProfilePictureWidget({
    Key? key,
    required this.profileUrl,
    required this.onTap,
    this.width = 140,
    this.height = 140,
    this.showEditIcon = true, this.borderRadius = 70
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(profileUrl);
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Stack(
          children: [
            profileUrl.contains('http')
                ? CircularCachedImage(
              imageUrl: profileUrl,
              width: width,
              height: height,
              borderRadius: borderRadius,
              errorPath: "assets/images/png/image_not_found.png",
              borderColor: Colors.grey.withOpacity(.1),
            )
                : Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(.1)),
                  borderRadius: BorderRadius.circular(borderRadius),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: profileUrl.contains('assets/')
                          ? AssetImage(profileUrl) as ImageProvider
                          : FileImage(
                        File(profileUrl),
                      ))),
            ),
            Positioned(
              bottom: -1,
              right: 0,
              child: Visibility(
                visible: showEditIcon,
                child: IconButton(
                    onPressed: onTap,
                    icon: Container(
                      height: 30,
                      width: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: context.colorScheme.background,
                          boxShadow: [
                            BoxShadow(
                              color: context.colorScheme.primary.withOpacity(0.8),
                              blurRadius: 2,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Icon(Icons.edit),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
