import 'package:flutter/material.dart';

class TextFieldWithOutBorder extends StatelessWidget {
  final double vMargin;
  final double hMargin;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final Function(String) onChanged;
  final TextInputType? keyboardType;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final VoidCallback? onSuffixTapped;
  final Widget? suffixIcon;
  const TextFieldWithOutBorder(
      {super.key,
      this.controller,
      required this.onChanged,
      this.keyboardType,
      this.obscureText = false,
      this.textInputAction,
      this.vMargin = 0,
      this.hMargin = 0,
      this.style,
      this.hintText,
      this.hintStyle,
      this.focusNode,
        this.suffixIcon,
      this.onSuffixTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vMargin, horizontal: hMargin),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        style: style,
        onChanged: onChanged,
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: hintStyle,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide.none,
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide.none,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide.none,
            ),
            suffixIcon: suffixIcon!= null ? suffixIcon: onSuffixTapped != null
                ? IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: onSuffixTapped,
                  )
                : SizedBox.shrink()),
      ),
    );
  }
}
