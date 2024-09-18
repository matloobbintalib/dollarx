import 'package:flutter/material.dart';
import 'package:dollarax/utils/utils.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      backgroundColor: context.colorScheme.background,
      surfaceTintColor: context.colorScheme.background,
      title: Text(title,style: TextStyle(
        color: Colors.black
      ), ),
      content: Text(message,style: TextStyle(
          color: Colors.black
      )),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: const Text('Yes'),
        ),
      ],
    );
  }
}
