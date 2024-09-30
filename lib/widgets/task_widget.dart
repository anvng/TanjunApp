import 'package:flutter/material.dart';
import 'package:tanjun_app/core/utils/app_colors.dart';

class TaskWidget extends StatelessWidget {
  final int index;

  const TaskWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // check or uncheck
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primaryColor, width: 0.8),
        ),
        child: const Icon(Icons.check, color: Colors.white),
      ),
    );
  }
}
