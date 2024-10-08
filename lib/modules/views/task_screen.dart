import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:tanjun_app/core/utils/app_colors.dart';
import 'package:tanjun_app/core/utils/task_strings.dart';
import 'package:tanjun_app/modules/viewmodels/rep_text_field.dart';
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

              SizedBox(
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

                    Builder(
                      builder: (BuildContext newContext) {
                        return GestureDetector(
                          onTap: () {
                            showBottomSheet(
                              context: newContext,
                              builder: (_) => SizedBox(
                                height: 280,
                                child: TimePickerWidget(),
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
                                    style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 16),
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
                                      style: TextStyle(
                                          color: Colors.grey.shade500),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
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
