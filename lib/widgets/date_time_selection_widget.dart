import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:tanjun_app/core/utils/app_colors.dart';
import 'package:tanjun_app/core/utils/task_strings.dart';

class DateTimeSelectionWidget extends StatelessWidget {
  const DateTimeSelectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext newContext) {
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: newContext,
              builder: (_) => SizedBox(
                height: 280,
                child: TimePickerWidget(
                  // initial time
                  onChange: (_, __) {},
                  dateFormat: 'HH:mm',
                  onConfirm: (dateTime, _) {},
                ),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(20),
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
                  child: Text(
                    TaskStrings.timeLabel,
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  width: 80,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.grey.shade100,
                  ),
                  child: Center(
                    child: Text(
                      "Time",
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}