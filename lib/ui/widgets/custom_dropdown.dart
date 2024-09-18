import 'package:flutter/material.dart';
import 'package:dollarax/utils/extensions/extended_context.dart';

import '../../constants/app_colors.dart';

class CustomDropDown extends StatefulWidget {
  final String hint;
  final List<String> items;
  final bool disable;
  final bool enable;
  final Color borderColor;
  final Color fillColor;
  final Color prefixIconColor;
  final Color hintColor;
  final bool isOutline;
  final String? suffixIconPath;
  final double suffixIconSize;
  final String? prefixIconPath;
  final double allPadding;
  final double verticalPadding;
  final double horizontalPadding;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Function(String value)? onSelect;
  final double height;

  const CustomDropDown(
      {Key? key,
      required this.hint,
      required this.items,
      this.height = 46,
      this.suffixIconSize = 12,
      this.hintColor = AppColors.white,
      this.fillColor = AppColors.fieldColor,
      this.prefixIconColor = AppColors.secondary,
      this.suffixIconPath,
      this.prefixIconPath,
      this.disable = false,
      this.enable = false,
      this.borderColor = AppColors.fieldColor,
      this.fontSize = 16,

      this.onSelect,
      this.isOutline = true,
      this.allPadding = 10,
      this.fontWeight = FontWeight.w400,
      this.horizontalPadding = 16,
      this.verticalPadding = 12})
      : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      alignment: Alignment.center,
      child: IgnorePointer(
        ignoring: widget.disable,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          child: DropdownButtonFormField(
            isExpanded: true,
            isDense: true,
            icon: Image.asset(
              widget.suffixIconPath == null?
              'assets/images/png/ic_drop_down.png' : widget.suffixIconPath.toString(),
              width: widget.suffixIconSize,
              height: widget.suffixIconSize,
            ),
            iconSize: 12,
            style: context.textTheme.bodySmall?.copyWith(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w300),
            hint: Text(
              widget.hint,
              style: context.textTheme.bodySmall?.copyWith(fontSize: 11, color: widget.hintColor, fontWeight: FontWeight.w300),
              overflow: TextOverflow.ellipsis,
            ),
            decoration: InputDecoration(
              filled: true,
              hintStyle:  context.textTheme.bodySmall?.copyWith(fontSize: 11, color: widget.hintColor, fontWeight: FontWeight.w500),
              prefixIcon: widget.prefixIconPath != null ? Container(
                margin: EdgeInsets.only(left: 18, right: 6),
                  child: Image.asset(widget.prefixIconPath.toString()), height: 32,width: 32) : null,
              enabled: widget.enable,
              fillColor: widget.fillColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(color: widget.borderColor, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide:
                    BorderSide(color: widget.borderColor, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide:
                    BorderSide(color: widget.borderColor, width: 1),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding,vertical: widget.verticalPadding)
            ),
            dropdownColor: AppColors.secondary,
            value: dropdownValue.isEmpty ? null :dropdownValue,
            borderRadius: BorderRadius.all(Radius.circular(6)),
            onChanged: (String? newValue) {
              if (widget.onSelect != null) {
                widget.onSelect!(newValue!);
              }
              setState(() {
                dropdownValue = newValue!;
              });
            },
            menuMaxHeight: 550,
            items: widget.items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  value,
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    color: Colors.white,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
