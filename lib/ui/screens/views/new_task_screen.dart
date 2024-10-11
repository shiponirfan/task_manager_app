import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/views/add_new_task.dart';
import 'package:task_manager_app/utils/app_colors.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTask(),
            ));
      },
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      child: const Icon(Icons.add),
    );
  }
}
