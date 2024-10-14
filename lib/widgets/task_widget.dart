import 'package:flutter/material.dart';
import 'package:tanjun_app/core/utils/app_colors.dart';
import 'package:tanjun_app/modules/models/task_model.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({
    super.key,
    required this.task,
    required this.onToggle,
    this.size = 60.0, // Default size
  });

  final TaskModel task;
  final Function(bool) onToggle;
  final double size; // Add size parameter

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  void initState() {
    super.initState();
  }

  void _toggleCompletion() {
    setState(() {
      // Toggle the completion state
      widget.task.isCompleted = !widget.task.isCompleted;

      // Save the updated task state in Hive
      widget.task.save(); // Save changes to Hive
    });
    // Notify the parent widget
    widget.onToggle(widget.task.isCompleted);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCompletion,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        width: widget.size, // Use the size parameter
        height: widget.size, // Use the size parameter
        decoration: BoxDecoration(
          color: widget.task.isCompleted
              ? AppColors.buttonColor
              : AppColors.uncompletedColor,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primaryColor, width: 0.8),
        ),
        child: Center(
          child: AnimatedScale(
            scale:
                widget.task.isCompleted ? 1.2 : 1.0, // Scale effect on toggle
            duration: const Duration(milliseconds: 300),
            child: Icon(
              widget.task.isCompleted
                  ? Icons.check
                  : Icons.radio_button_unchecked,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
