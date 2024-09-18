import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dollarax/utils/utils.dart';

import '../../constants/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.hMargin = 0,
      this.height = 46,
      this.width = double.infinity,
      this.backgroundColor,
      this.titleColor = AppColors.black,
      this.borderColor = AppColors.secondary,
      this.fontWeight = FontWeight.w600,
      this.fontSize,
      this.fontWidget,
      this.suffixIconPath,
      this.borderRadius = 6})
      : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final double hMargin;
  final double height;
  final double width;
  final Color? backgroundColor;
  final Color? titleColor;
  final double borderRadius;
  final Color borderColor;
  final FontWeight fontWeight;
  final double? fontSize;
  final Widget? fontWidget;
  final String? suffixIconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(horizontal: hMargin),
      child: ElevatedButton(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: context.textTheme.titleLarge!.copyWith(
                  fontWeight: fontWeight,
                  color: titleColor,
                  fontSize: fontSize ?? null,
                ),
              ),
            ),
            if (suffixIconPath != null)
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: SvgPicture.asset(
                  suffixIconPath!,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.background,
                    BlendMode.srcIn,
                  ),
                ),
              ),
          ],
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide(color: borderColor)),
          backgroundColor: backgroundColor ?? AppColors.secondary,
        ),
      ),
    );
  }
}

class PrimaryTextButton extends StatelessWidget {
  const PrimaryTextButton(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.height = 50,
      this.backgroundColor,
      this.foregroundColor,
      this.fontSize,
      this.prefixIconPath,
      this.borderRadius = 10})
      : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final double? fontSize;
  final double height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double borderRadius;
  final String? prefixIconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      child: TextButton(
        child: Stack(
          children: [
            Center(
              child: Text(
                title,
                style: context.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize,
                    color: context.colorScheme.secondary),
              ),
            ),
            if (prefixIconPath != null)
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: SvgPicture.asset(
                  height: 26,
                  prefixIconPath!,
                  colorFilter: ColorFilter.mode(
                    context.colorScheme.secondary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
          ],
        ),
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: context.colorScheme.secondary),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
