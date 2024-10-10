import 'package:flutter/material.dart';
import 'package:tanjun_app/core/utils/app_colors.dart';
import 'package:tanjun_app/modules/models/task_model.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    super.key,
    required this.task,
    required this.onToggle,
  });

  final TaskModel task;
  final Function(bool) onToggle;

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.task.isCompleted;
  }

  void _toggleCompletion() {
    setState(() {
      isCompleted = !isCompleted;
    });
    widget.onToggle(isCompleted);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCompletion,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        decoration: BoxDecoration(
          color:
              isCompleted ? AppColors.buttonColor : AppColors.uncompletedColor,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primaryColor, width: 0.8),
        ),
        child: Icon(
          isCompleted ? Icons.check : Icons.radio_button_unchecked,
          color: Colors.white,
        ),
      ),
    );
  }
}
