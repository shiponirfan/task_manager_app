import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/screens/views/canceled_task_screen.dart';
import 'package:task_manager_app/ui/screens/views/completed_task_screen.dart';
import 'package:task_manager_app/ui/screens/views/new_task_screen.dart';
import 'package:task_manager_app/ui/screens/views/progress_task_screen.dart';
import 'package:task_manager_app/ui/widgets/appbar_widget.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _selectedIndex = 0;
  final List<Widget> _views = [
    const NewTaskScreen(),
    const ProgressTaskScreen(),
    const CompletedTaskScreen(),
    const CanceledTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      bottomNavigationBar: _buildNavigationBar(_selectedIndex),
      body: _views[_selectedIndex],
    );
  }

  Widget _buildNavigationBar(int selectedIndex) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (value) {
        _selectedIndex = value;
        setState(() {});
      },
      destinations: const [
        NavigationDestination(
            icon: Icon(Icons.new_label_outlined), label: 'New'),
        NavigationDestination(
            icon: Icon(Icons.access_alarm_rounded), label: 'Progress'),
        NavigationDestination(
            icon: Icon(Icons.task_alt_rounded), label: 'Completed'),
        NavigationDestination(
            icon: Icon(Icons.cancel_outlined), label: 'Canceled'),
      ],
      backgroundColor: Colors.white,
      elevation: 1,
    );
  }
}
