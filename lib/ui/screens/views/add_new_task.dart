import 'package:flutter/material.dart';
import 'package:task_manager_app/data/models/network_response.dart';
import 'package:task_manager_app/data/services/network_caller.dart';
import 'package:task_manager_app/ui/widgets/appbar_widget.dart';
import 'package:task_manager_app/ui/widgets/image_background.dart';
import 'package:task_manager_app/utils/snackbar_widget.dart';
import 'package:task_manager_app/utils/urls.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});
  static String route = '/add-new-task';

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isPending = false;
  bool isRefreshed = false;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const AppBarWidget(),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            return;
          } else {
            Navigator.of(context).pop(isRefreshed);
          }
        },
        child: ImageBackground(
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
      ),
    );
  }

  Widget _buildAddTaskForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _subjectTEController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Subject',
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter Subject';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _descriptionTEController,
            maxLines: 6,
            decoration: const InputDecoration(
              hintText: 'Description',
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Enter Description';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
              onPressed: _onTapSubmitButton,
              child: Container(
                  padding: const EdgeInsets.all(4),
                  child: isPending
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Add Task',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ))),
        ],
      ),
    );
  }

  void _onTapSubmitButton() {
    if (_formKey.currentState!.validate()) {
      _addNewTask();
    }
  }

  void _addNewTask() async {
    isPending = true;
    setState(() {});
    Map<String, dynamic> bodyData = {
      'title': _subjectTEController.text.trim(),
      'description': _descriptionTEController.text.trim(),
      "status": 'New',
    };

    NetworkResponse response = await NetworkCaller.postRequest(
        url: Urls.createTaskUrl, body: bodyData);
    isPending = false;
    setState(() {});
    if (response.isSuccess) {
      _clearTextFields();
      snackBarWidget(context: context, message: 'New Task Added');
      setState(() {
        isRefreshed = true;
      });
    } else {
      snackBarWidget(
          context: context, message: response.errorMessage, isError: true);
    }
  }

  void _clearTextFields() {
    _subjectTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
