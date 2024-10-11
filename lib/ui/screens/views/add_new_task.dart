import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/appbar_widget.dart';
import 'package:task_manager_app/ui/widgets/image_background.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const AppBarWidget(),
      body: ImageBackground(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 44,
                ),
                Text(
                  'Get Started With',
                  style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                _buildAddTaskForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAddTaskForm() {
    return Column(
      children: [
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Subject',
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          maxLines: 6,
          decoration: const InputDecoration(
            hintText: 'Description',
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
            onPressed: _onTapSubmitButton,
            child: Container(
                padding: const EdgeInsets.all(4),
                child: const Text(
                  'Add Task',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ))),
      ],
    );
  }
}

void _onTapSubmitButton() {}
