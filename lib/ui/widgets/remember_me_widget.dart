import 'package:flutter/material.dart';
import 'package:dollarax/ui/widgets/on_click.dart';
import 'package:dollarax/utils/utils.dart';

class RememberMeWidget extends StatefulWidget {
  final Function(bool value)? onTab;
  final String title;
  final double fontSize;
  final double checkBoxSize;
  final Color? checkColor;
  final Color? titleColor;

   const RememberMeWidget(
      {super.key,
      this.onTab,
      this.title = 'Remember me',
      this.fontSize = 12,
      this.checkBoxSize = 16,
      this.checkColor, this.titleColor });

  @override
  State<RememberMeWidget> createState() => _RememberMeWidgetState();
}

class _RememberMeWidgetState extends State<RememberMeWidget> {
  bool isKeepMeLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OnClick(
          onTap: () {
            setState(() {
              isKeepMeLoggedIn = !isKeepMeLoggedIn;
            });
            if (widget.onTab != null) {
              widget.onTab!(isKeepMeLoggedIn);
            }
          },
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: context.colorScheme.outline),
                color: context.colorScheme.outline ?? Colors.grey.withOpacity(.2)),
            height: widget.checkBoxSize,
            width: widget.checkBoxSize,
            margin: const EdgeInsets.only(left: 5),
            child: Center(
              child: Icon(
                Icons.check,
                color: isKeepMeLoggedIn
                    ? context.colorScheme.primary
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
                color: widget.titleColor ??   context.colorScheme.onSecondary,
                  fontSize: widget.fontSize),
        ),
      ],
    );
  }
}
