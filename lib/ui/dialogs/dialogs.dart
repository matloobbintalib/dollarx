import 'package:dollarx/modules/user/cubits/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'confirmation_dialog.dart';

sealed class Dialogs {
  Dialogs_();

  static Future<void> showLogOutConfirmationDialog(
    BuildContext context,
  ) async {
    final confirmed = await _showConfirmationDialog(
      context,
      title: 'Sign Out',
      message: 'Are you sure you want to sign out?',
    );

    if (confirmed && context.mounted) {
      context.read<UserCubit>().logout();
    }
  }

  static Future<void> showDeleteAccountConfirmationDialog(
    BuildContext context,
  ) async {
    final confirmed = await _showConfirmationDialog(
      context,
      title: 'Delete Account',
      message: 'Are you sure you want to delete your account forever? '
          'It can take up to 30 days. This cannot be undone.',
    );

    if (confirmed && context.mounted) {
      // TODO: implement delete account
      // context.showSnackBar('Request submitted.');
    }
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
