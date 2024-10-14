import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:tanjun_app/core/utils/app_colors.dart';
import 'package:tanjun_app/core/utils/task_strings.dart';
import 'package:tanjun_app/modules/models/task_model.dart';
import 'package:tanjun_app/modules/viewmodels/rep_text_field.dart';
import 'package:tanjun_app/widgets/date_time_selection_widget.dart';
import 'package:tanjun_app/widgets/task_bar_widget.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({
    super.key,
    required this.titleTaskController,
    required this.descriptionTaskController,
    required this.task,
  });

  final TextEditingController? titleTaskController;
  final TextEditingController? descriptionTaskController;
  final TaskModel? task;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final _titleTaskController = TextEditingController();
  final _descriptionTaskController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  bool isTaskAlreadyExists() {
    return _titleTaskController.text.isEmpty &&
        _descriptionTaskController.text.isEmpty;
  }

  // format date
  String formatDate(DateTime date) {
    final dayOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
    return '${dayOfWeek[date.weekday - 1]}, ${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: TaskBarWidget(),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              // top side texts
              _buildTopSideTexts(),
              // main task screen
              _buildMainTaskScreenActivity(context),
              // bottom side buttons
              _buildBottomSideButtons(),
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
          // cancel button
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
          // save button
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
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          // title input
          RepTextField(
            titleController: _titleTaskController,
          ),
          const SizedBox(height: 40),
          // description input
          RepTextField(
            titleController: _descriptionTaskController,
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
                    initDateTime: DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    ),
                    onConfirm: (dateTime, _) {
                      setState(() {
                        selectedTime = TimeOfDay.fromDateTime(dateTime);
                      });
                    },
                  ),
                ),
              );
            },
            // show formatted time
            title:
                '${selectedTime.hourOfPeriod}:${selectedTime.minute.toString().padLeft(2, '0')} ${selectedTime.hour >= 12 ? 'P.M' : 'A.M'}',
          ),
          // date select
          DateTimeSelectionWidget(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                maxDateTime: DateTime(2050, 12, 31),
                minDateTime: DateTime.now(),
                onConfirm: (dateTime, _) {
                  setState(() {
                    selectedDate = dateTime;
                  });
                },
              );
            },
            // show formatted date
            title: formatDate(selectedDate),
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
            text: TextSpan(
              text: isTaskAlreadyExists()
                  ? TaskStrings.addTask
                  : TaskStrings.updateTask,
              style: const TextStyle(
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
