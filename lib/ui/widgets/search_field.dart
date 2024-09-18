
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';

import '../../constants/app_colors.dart';
import '../../utils/validators/validators.dart';


class SearchField extends StatefulWidget {
  const SearchField({
    required this.controller,
    required this.label,
    required this.textInputAction,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLines,
    this.inputFormatters = null,
    this.readOnly = false,
    this.onTap,
    this.autoFocus = false,
    super.key,
    this.onChange,
    this.fillColor = AppColors.fieldColor,
    this.hintColor = AppColors.grey1,
    this.borderRadius = 6,
    this.edgeInsetsGeometry = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  });

  final TextEditingController controller;
  final String label;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final double borderRadius;
  final EdgeInsetsGeometry edgeInsetsGeometry;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool autoFocus;
  final Function(String)? onChange;
  final Color fillColor;
  final Color hintColor;
@override
State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    final validator =
        widget.validator ?? Validators.getValidator(widget.keyboardType);

    return Stack(
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          obscureText: widget.obscureText,
          validator: validator,
          enabled: true,
          onTap: widget.onTap,
          autofocus: widget.autoFocus,
          readOnly: widget.readOnly,
          cursorColor: Colors.white,
          inputFormatters: widget.inputFormatters,
          onFieldSubmitted: widget.onFieldSubmitted,
          maxLines: widget.maxLines,
          onChanged: widget.onChange,
          style: TextStyle(
            color: Colors.white, // Set your desired text color here
          ),
          decoration: InputDecoration(
            hintText: widget.label,
            hintStyle: context.textTheme.bodySmall?.copyWith(
              color: widget.hintColor,
            ),
            fillColor: widget.fillColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide:
              BorderSide(color: AppColors.secondary, ),
            ),
            contentPadding: widget.edgeInsetsGeometry,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide:
              BorderSide(color: AppColors.secondary,),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide:
              BorderSide(color: AppColors.secondary,),
            ),
            prefixIcon: widget.prefixIcon,
          ),
        ),
        Positioned(
          right: 0,
          top: -1,
          child: Align(
            alignment: Alignment.centerRight,
            child: widget.suffixIcon,
          ),
        )
      ],
    );
  }
}
