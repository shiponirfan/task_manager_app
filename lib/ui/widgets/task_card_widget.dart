import 'package:flutter/material.dart';
import 'package:task_manager_app/utils/app_colors.dart';

class TaskCardWidget extends StatefulWidget {
  const TaskCardWidget({
    super.key,
  });

  @override
  State<TaskCardWidget> createState() => _TaskCardWidgetState();
}

class _TaskCardWidgetState extends State<TaskCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Title Of Task',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              '${'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual'.substring(0, 80)}...',
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              'Date: 12/12/2024',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTaskChip(),
                Wrap(
                  children: [
                    IconButton(
                        onPressed: _onTapEditTask,
                        icon: const Icon(
                          Icons.edit_note_rounded,
                          color: AppColors.primaryColor,
                        )),
                    IconButton(
                        onPressed: _onTapDeleteTask,
                        icon: const Icon(
                          Icons.delete_forever_rounded,
                          color: Colors.red,
                        )),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTaskChip() {
    return Chip(
      label: const Text(
        'New',
      ),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
    );
  }

  void _onTapEditTask() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['New', 'Progress', 'Completed', 'Canceled'].map((e) {
              return ListTile(
                onTap: () {
                  // TODO: Add Edit Status Option
                },
                title: Text(e),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancle')),
            TextButton(
                onPressed: () {
                  // TODO: Add Edit Status Okay Button Option
                },
                child: const Text('Okay')),
          ],
        );
      },
    );
  }

  void _onTapDeleteTask() {}
}
