import 'package:flutter/material.dart';
import 'package:tanjun_app/core/utils/app_colors.dart';
import 'package:tanjun_app/core/utils/task_strings.dart';

class DateTimeSelectionWidget extends StatelessWidget {
  const DateTimeSelectionWidget({
    super.key,
    required this.onTap,
    required this.title,
    this.label = TaskStrings.timeLabel, // Default label
  });

  final VoidCallback onTap;
  final String title;
  final String label; // New parameter for customizable label

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Semantics(
                label: label, // Semantic label for accessibility
                child: Text(
                  label,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 12),
              width: 120,
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: Colors.grey.shade100,
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(color: Colors.grey.shade500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
