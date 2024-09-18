import 'package:flutter/material.dart';
import 'package:dollarax/ui/widgets/on_click.dart';
import 'package:dollarax/utils/utils.dart';

class CustomRadioButtonWidget extends StatefulWidget {
  final Function(bool value)? onChange;
  final String title;
  final double fontSize;
  final double checkBoxSize;
  final Color? checkColor;
  final Color? titleColor;

  const CustomRadioButtonWidget(
      {super.key,
        this.onChange,
        this.title = 'Remember me',
        this.fontSize = 12,
        this.checkBoxSize = 16,
        this.checkColor, this.titleColor = Colors.white });

  @override
  State<CustomRadioButtonWidget> createState() => _CustomRadioButtonWidgetState();
}

class _CustomRadioButtonWidgetState extends State<CustomRadioButtonWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OnClick(
          onTap: () {
            setState(() {
              isSelected = !isSelected;
            });
            if (widget.onChange != null) {
              widget.onChange!(isSelected);
            }
          },
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
                color: Colors.black),
            height: widget.checkBoxSize,
            width: widget.checkBoxSize,
            margin: const EdgeInsets.only(left: 5),
            child: Center(
              child: Icon(
                Icons.radio_button_checked_outlined,
                color: isSelected
                    ? Colors.white
                    : Colors.transparent,
                size: widget.checkBoxSize - 2,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          widget.title,
          style:
          context.textTheme.bodySmall?.copyWith(
              color: widget.titleColor ,
              fontSize: widget.fontSize),
        ),
      ],
    );
  }
}
