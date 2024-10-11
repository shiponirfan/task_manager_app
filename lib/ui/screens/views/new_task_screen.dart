import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/views/add_new_task.dart';
import 'package:task_manager_app/ui/widgets/task_summary_card_widget.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [_buildTaskCount()],
        ),
      ),
    );
  }

  Widget _buildTaskCount() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          TaskSummaryCardWidget(
            count: 09,
            taskName: 'New',
          ),
          TaskSummaryCardWidget(
            count: 03,
            taskName: 'Progress',
          ),
          TaskSummaryCardWidget(
            count: 04,
            taskName: 'Completed',
          ),
          TaskSummaryCardWidget(
            count: 01,
            taskName: 'Canceled',
          ),
        ],
      ),
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: _onTapFAB,
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      child: const Icon(Icons.add),
    );
  }

  void _onTapFAB() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AddNewTask(),
        ));
  }
}
