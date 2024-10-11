import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/task_card_widget.dart';
import 'package:task_manager_app/utils/app_colors.dart';

class CanceledTaskScreen extends StatefulWidget {
  const CanceledTaskScreen({super.key});

  @override
  State<CanceledTaskScreen> createState() => _CanceledTaskScreenState();
}

class _CanceledTaskScreenState extends State<CanceledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor.withOpacity(0.08),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Expanded(
          child: ListView.separated(
            itemBuilder: (context, index) {
              return const TaskCardWidget();
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 8,
              );
            },
            itemCount: 10,
          ),
        ),
      ),
    );
  }
}
