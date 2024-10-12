import 'package:flutter/material.dart';
import 'package:task_manager_app/utils/app_colors.dart';

void snackBarWidget(
    {required BuildContext context,
    required String message,
    bool isError = false}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
    backgroundColor: isError == true ? Colors.red : AppColors.primaryColor,
  ));
}
