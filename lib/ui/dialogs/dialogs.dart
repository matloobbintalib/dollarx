import 'package:flutter/material.dart';

import 'confirmation_dialog.dart';

sealed class Dialogs {
  Dialogs_();

  static Future<bool> showLogOutConfirmationDialog(
    BuildContext context
  ) async {
    final confirmed = await _showConfirmationDialog(
      context,
      title: 'Sign Out',
      message: 'Are you sure you want to sign out?',
    );
    return confirmed;
  }

  static Future<bool> showDeleteAccountConfirmationDialog(
    BuildContext context,
  ) async {
    final confirmed = await _showConfirmationDialog(
      context,
      title: 'Delete Account',
      message: 'Are you sure you want to delete your account forever? '
          'It can take up to 30 days. This cannot be undone.',
    );

    return confirmed;
  }

  static Future<bool> _showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    bool? res = await showAdaptiveDialog<bool>(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: title,
        message: message,
      ),
    );
    return res ?? false;
  }
}
