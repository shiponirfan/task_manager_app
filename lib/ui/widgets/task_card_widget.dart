import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/models/task_model.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/utils/app_colors.dart';
import 'package:task_manager_app/utils/snackbar_widget.dart';
import 'package:task_manager_app/utils/urls.dart';


class TaskCardWidget extends StatefulWidget {
  final TaskModel task;
  final VoidCallback isRefreshed;

  const TaskCardWidget({
    super.key,
    required this.task,
    required this.isRefreshed,
  });

  @override
  State<TaskCardWidget> createState() => _TaskCardWidgetState();
}

class _TaskCardWidgetState extends State<TaskCardWidget> {
  String _selectedTaskStatus = '';

  @override
  void initState() {
    super.initState();
    _selectedTaskStatus = widget.task.status!;
  }

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
            Text(
              widget.task.title ?? 'No Title',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              (widget.task.description?.length ?? 0) > 80
                  ? '${widget.task.description!.substring(0, 80)}...'
                  : widget.task.description ?? 'No Description',
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'Date: ${widget.task.createdDate?.substring(0, 10) ?? 'N/A'}',
              style: const TextStyle(fontWeight: FontWeight.w600),
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
      label: Text(
        widget.task.status!,
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
                  _onTapChangeTaskStatus(e);
                },
                selected: _selectedTaskStatus == e,
                title: Text(e),
                trailing:
                    _selectedTaskStatus == e ? const Icon(Icons.check) : null,
              );
            }).toList(),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
          ],
        );
      },
    );
  }

  Future<void> _onTapChangeTaskStatus(String status) async {
    NetworkResponse response = await NetworkCaller.getRequest(
        Urls.updateTaskStatus(widget.task.sId!, status));
    if (response.isSuccess) {
      widget.isRefreshed();
      Navigator.pop(context);
    } else {
      snackBarWidget(
          context: context, message: response.errorMessage, isError: true);
    }
  }

  Future<void> _onTapDeleteTask() async {
    NetworkResponse response =
        await NetworkCaller.getRequest(Urls.deleteTaskStatus(widget.task.sId!));
    if (response.isSuccess) {
      widget.isRefreshed();
    } else {
      snackBarWidget(
          context: context, message: response.errorMessage, isError: true);
    }
  }
}
