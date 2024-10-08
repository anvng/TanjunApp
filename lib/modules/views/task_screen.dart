import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:tanjun_app/core/utils/app_colors.dart';
import 'package:tanjun_app/core/utils/task_strings.dart';
import 'package:tanjun_app/modules/viewmodels/rep_text_field.dart';
import 'package:tanjun_app/widgets/date_time_selection_widget.dart';
import 'package:tanjun_app/widgets/task_bar_widget.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen(
      {super.key, required GlobalKey<SliderDrawerState> drawerKey});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController controller = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: TaskBarWidget()),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              // top side
              _buildTopSideTexts(),
              // main task screen
              _buildMainTaskScreenActivity(context),
              // bottom side buttons
              _buildBottomSideButtons()
            ],
          ),
        ),
      ),
    );
  }

  // bottom side buttons
  Widget _buildBottomSideButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // delete current task
          MaterialButton(
            onPressed: () {},
            color: AppColors.secondaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            height: 50,
            child: const Row(
              children: [
                Icon(
                  Icons.close,
                  color: AppColors.buttonColor,
                ),
                Text(
                  TaskStrings.cancelTask,
                  style: TextStyle(color: AppColors.buttonColor),
                ),
              ],
            ),
          ),
          // add and save current task
          MaterialButton(
            onPressed: () {},
            color: AppColors.buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            height: 50,
            child: const Row(
              children: [
                Icon(
                  Icons.save,
                  color: AppColors.whiteColor,
                ),
                Text(
                  TaskStrings.addTask,
                  style: TextStyle(color: AppColors.whiteColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // main task screen
  Widget _buildMainTaskScreenActivity(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 540,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              TaskStrings.taskTitleHint,
              style: TextStyle(
                  fontSize: 18,
                  color: AppColors.textHintColor,
                  fontWeight: FontWeight.w300),
            ),
          ),

          // title
          RepTextField(titleController: controller),
          const SizedBox(height: 40),
          // description
          RepTextField(
            titleController: _descriptionController,
            isForDescription: true,
          ),
          // time select
          DateTimeSelectionWidget(
            onTap: () {
              showModalBottomSheet(
                context: context,
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
            title: TaskStrings.timeLabel,
          ),
          // date select
          DateTimeSelectionWidget(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                maxDateTime: DateTime(2050, 23, 1),
                minDateTime: DateTime.now(),
                onConfirm: (dateTime, _) {},
              );
            },
            title: TaskStrings.dateLabel,
          ),
        ],
      ),
    );
  }

  // top side texts
  Widget _buildTopSideTexts() {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
          RichText(
            text: const TextSpan(
              text: TaskStrings.addNewTask,
              style: TextStyle(
                color: AppColors.textColor,
                fontWeight: FontWeight.w400,
                fontSize: 33,
              ),
            ),
          ),
          const SizedBox(
            width: 70,
            child: Divider(
              thickness: 2,
            ),
          ),
        ],
      ),
    );
  }
}
