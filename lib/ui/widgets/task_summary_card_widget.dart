import 'package:flutter/material.dart';

class TaskSummaryCardWidget extends StatelessWidget {
  const TaskSummaryCardWidget({
    super.key,
    required this.count,
    required this.taskName,
  });

  final int count;
  final String taskName;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Card(
      elevation: 0,
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: SizedBox(
        width: (MediaQuery.of(context).size.width / 4) - 13,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                count.toString(),
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              FittedBox(
                child: Text(
                  taskName,
                  style: const TextStyle(
                      color: Colors.black54, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
