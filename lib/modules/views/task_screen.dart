import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:tanjun_app/core/utils/app_colors.dart';
import 'package:tanjun_app/core/utils/task_strings.dart';
import 'package:tanjun_app/modules/models/task_model.dart';
import 'package:tanjun_app/modules/viewmodels/rep_text_field.dart';
import 'package:tanjun_app/widgets/date_time_selection_widget.dart';
import 'package:tanjun_app/widgets/task_bar_widget.dart';
import 'package:uuid/uuid.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({
    super.key,
    required this.titleTaskController,
    required this.descriptionTaskController,
    required this.tasks,
  });

  final TextEditingController? titleTaskController;
  final TextEditingController? descriptionTaskController;
  final TaskModel? tasks;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  late TextEditingController _titleTaskController;
  late TextEditingController _descriptionTaskController;

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _titleTaskController =
        widget.titleTaskController ?? TextEditingController();
    _descriptionTaskController =
        widget.descriptionTaskController ?? TextEditingController();

    if (widget.tasks != null) {
      _titleTaskController.text = widget.tasks!.title;
      _descriptionTaskController.text = widget.tasks!.description;
      selectedDate = widget.tasks!.atDate;
      selectedTime = TimeOfDay.fromDateTime(widget.tasks!.atTime);
    }
  }

  @override
  void dispose() {
    _titleTaskController.dispose();
    _descriptionTaskController.dispose();
    super.dispose();
  }

  void _saveTask() {
    final title = _titleTaskController.text.trim();
    final description = _descriptionTaskController.text.trim();

    if (!_validateInputs(title, description)) return;

    final task = TaskModel(
      id: widget.tasks?.id ?? const Uuid().v4(),
      title: title,
      description: description,
      atTime: DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      ),
      atDate: selectedDate,
      isCompleted: false,
    );

    // Implement my task saving logic here

    // Close the screen after saving
    Navigator.pop(context);
  }

  bool _validateInputs(String title, String description) {
    if (title.isEmpty || description.isEmpty) {
      _showErrorDialog('Title and description cannot be empty.');
      return false;
    }
    return true;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _cancelTask() {
    Navigator.pop(context); // Close the screen without saving
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTopSideTexts(),
              _buildMainTaskScreenActivity(),
              _buildBottomSideButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSideButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildCancelButton(),
          _buildSaveButton(),
        ],
      ),
    );
  }

  MaterialButton _buildCancelButton() {
    return MaterialButton(
      onPressed: _cancelTask,
      color: AppColors.secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      height: 50,
      child: const Row(
        children: [
          Icon(Icons.close, color: AppColors.buttonColor),
          Text(TaskStrings.cancelTask,
              style: TextStyle(color: AppColors.buttonColor)),
        ],
      ),
    );
  }

  MaterialButton _buildSaveButton() {
    return MaterialButton(
      onPressed: _saveTask,
      color: AppColors.buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      height: 50,
      child: const Row(
        children: [
          Icon(Icons.save, color: AppColors.whiteColor),
          Text(TaskStrings.addTask,
              style: TextStyle(color: AppColors.whiteColor)),
        ],
      ),
    );
  }

  Widget _buildMainTaskScreenActivity() {
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
          RepTextField(titleController: _titleTaskController),
          const SizedBox(height: 40),
          RepTextField(
              titleController: _descriptionTaskController,
              isForDescription: true),
          _buildDateTimeSelection(),
        ],
      ),
    );
  }

  Widget _buildDateTimeSelection() {
    return Column(
      children: [
        _buildTimeSelection(),
        _buildDateSelection(),
      ],
    );
  }

  Widget _buildTimeSelection() {
    return DateTimeSelectionWidget(
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
      title:
          '${selectedTime.hourOfPeriod}:${selectedTime.minute.toString().padLeft(2, '0')} ${selectedTime.hour >= 12 ? 'P.M' : 'A.M'}',
    );
  }

  Widget _buildDateSelection() {
    return DateTimeSelectionWidget(
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
      title: formatDate(selectedDate),
    );
  }

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
            child: Divider(thickness: 2),
          ),
          RichText(
            text: TextSpan(
              text: widget.tasks == null
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
            child: Divider(thickness: 2),
          ),
        ],
      ),
    );
  }

  String formatDate(DateTime dateTime) {
    // Use your preferred date formatting logic
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
