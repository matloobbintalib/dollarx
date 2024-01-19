import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dollarx/utils/extensions/extended_context.dart';

import '../../constants/app_colors.dart';
import '../../utils/validators/validators.dart';

class InputField extends StatefulWidget {
  const InputField({
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
    this.hPadding = 12,
    this.vPadding = 10,
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
  final double hPadding;
  final double vPadding;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool autoFocus;
  final Function(String)? onChange;
  final Color fillColor;
  final Color hintColor;

  InputField.name({
    required TextEditingController controller,
    String label = 'Name',
    Function(String)? onChange,
    TextInputAction textInputAction = TextInputAction.next,
    ValueChanged<String>? onFieldSubmitted,
    Widget? suffixIcon,
  }) : this(
          controller: controller,
          label: label,
          textInputAction: textInputAction,
          keyboardType: TextInputType.name,
          validator: Validators.required,
          onFieldSubmitted: onFieldSubmitted,
          suffixIcon: suffixIcon,
          onChange: onChange,
        );

  InputField.phone(
      {required TextEditingController controller,
      String label = 'Phone',
      TextInputAction textInputAction = TextInputAction.next,
      ValueChanged<String>? onFieldSubmitted,
      List<TextInputFormatter>? inputFormatters})
      : this(
            controller: controller,
            label: label,
            textInputAction: textInputAction,
            keyboardType: TextInputType.phone,
            validator: Validators.required,
            onFieldSubmitted: onFieldSubmitted,
            inputFormatters: inputFormatters);

  InputField.email({
    required TextEditingController controller,
    String label = 'Email',
    Function(String)? onChange,
    TextInputAction textInputAction = TextInputAction.next,
    ValueChanged<String>? onFieldSubmitted,
    Widget? suffixIcon,
  }) : this(
          controller: controller,
          label: label,
          textInputAction: textInputAction,
          keyboardType: TextInputType.emailAddress,
          validator: Validators.email,
          onFieldSubmitted: onFieldSubmitted,
          suffixIcon: suffixIcon,
          onChange: onChange,
        );

  InputField.password({
    required TextEditingController controller,
    required Widget suffixIcon,
    required bool obscureText,
    String label = 'Password',
    TextInputAction textInputAction = TextInputAction.next,
    ValueChanged<String>? onFieldSubmitted,
  }) : this(
          controller: controller,
          label: label,
          textInputAction: textInputAction,
          keyboardType: TextInputType.visiblePassword,
          validator: Validators.password,
          onFieldSubmitted: onFieldSubmitted,
          obscureText: obscureText,
          suffixIcon: suffixIcon,
    maxLines: 1
        );

  InputField.confirmPassword({
    required TextEditingController controller,
    required TextEditingController confirmPasswordController,
    required Widget suffixIcon,
    required bool obscureText,
    required ValueChanged<String>? onFieldSubmitted,
    String label = 'Confirm Password',
    TextInputAction textInputAction = TextInputAction.done,
    Key? key,
  }) : this(
          key: key,
          controller: controller,
          label: label,
          textInputAction: textInputAction,
          keyboardType: TextInputType.visiblePassword,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            if (value != confirmPasswordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
          onFieldSubmitted: onFieldSubmitted,
          obscureText: obscureText,
          suffixIcon: suffixIcon,
    maxLines:
      1
        );

  InputField.number({
    required TextEditingController controller,
    String label = 'Name',
    TextInputAction textInputAction = TextInputAction.next,
    List<TextInputFormatter>? inputFormatters,
    ValueChanged<String>? onFieldSubmitted,
    Widget? prefixIcon,
  }) : this(
            controller: controller,
            label: label,
            textInputAction: textInputAction,
            keyboardType: TextInputType.number,
            validator: Validators.required,
            onFieldSubmitted: onFieldSubmitted,
            prefixIcon: prefixIcon,
            inputFormatters: inputFormatters ??
                [
                  FilteringTextInputFormatter.digitsOnly,
                ]);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
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
            contentPadding: EdgeInsets.symmetric(horizontal: widget.hPadding, vertical: widget.vPadding),
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
