import 'package:easy_bank/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

enum SnackbarType { success, error }

class CustomSnackbar {
  static void show(
      BuildContext context, {
        required String message,
        required SnackbarType type,
        Duration duration = const Duration(seconds: 3),
      }) {
    final Color backgroundColor = type == SnackbarType.success
        ? AppColors.snackBarSuccess
        : AppColors.snackBarError;

    final IconData icon = type == SnackbarType.success
        ? Icons.check_circle
        : Icons.error;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: AppColors.lightInputFill),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.lightInputFill,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: duration,
      ),
    );
  }
}