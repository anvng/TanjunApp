import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:lottie/lottie.dart';
import 'package:tanjun_app/core/utils/app_colors.dart';
import 'package:tanjun_app/core/utils/task_strings.dart';
import 'package:tanjun_app/modules/models/task_model.dart';
import 'package:tanjun_app/modules/viewmodels/custom_drawer.dart';
import 'package:tanjun_app/modules/views/bar_screen.dart';
import 'package:tanjun_app/widgets/fab_widget.dart';
import 'package:tanjun_app/widgets/task_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<TaskModel> tasks = [
    TaskModel(
      id: '1',
      title: 'Complete homework',
      description: 'Math homework needs to be done.',
      atTime: DateTime.now(),
      atDate: DateTime.now(),
      isCompleted: false,
    ),
    TaskModel(
      id: '2',
      title: 'Review chapter 2',
      description: 'Revise the physics notes.',
      atTime: DateTime.now(),
      atDate: DateTime.now(),
      isCompleted: false,
    ),
    TaskModel(
      id: '3',
      title: 'Complete project proposal',
      description: 'Complete the project proposal.',
      atTime: DateTime.now(),
      atDate: DateTime.now(),
      isCompleted: false,
    ),
  ];

  final GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    // Count uncompleted tasks
    int incompleteTasksCount = tasks.where((task) => !task.isCompleted).length;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      floatingActionButton: Fab(drawerKey: drawerKey),
      body: SliderDrawer(
        key: drawerKey,
        sliderOpenSize: 250,
        appBar: BarScreen(
          drawerKey: drawerKey,
          onDeleteAll: () {
            tasks.clear();
          },
        ),
        slider: CustomDrawer(),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              // Header with progress indicator
              Container(
                margin: const EdgeInsets.only(top: 20),
                width: double.infinity,
                height: 100,
                color: AppColors.whiteColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        value: tasks.isNotEmpty
                            ? incompleteTasksCount / tasks.length
                            : 0.0,
                        backgroundColor: AppColors.circleColor,
                        valueColor:
                            const AlwaysStoppedAnimation(AppColors.buttonColor),
                      ),
                    ),
                    const SizedBox(width: 25),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TaskStrings.mainTitle,
                          style: textTheme.titleLarge?.copyWith(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 50,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          "$incompleteTasksCount of ${tasks.length} tasks",
                          style: textTheme.titleMedium?.copyWith(
                            color: AppColors.textColor.withOpacity(0.5),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 24),
                child: Divider(
                  thickness: 2,
                  indent: 97,
                ),
              ),
              Expanded(
                child: tasks.isNotEmpty
                    ? ListView.builder(
                        itemCount: tasks.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(tasks[index].id.toString()),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.delete, color: Colors.white),
                                  SizedBox(width: 10),
                                  Text(
                                    'Deleted Successfully!',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            confirmDismiss: (direction) async {
                              return await showDialog<bool>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Confirm Delete"),
                                    content: const Text(
                                        "Are you sure you want to delete this task?"),
                                    actions: [
                                      TextButton(
                                        child: const Text("Cancel"),
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                      ),
                                      TextButton(
                                        child: const Text("Delete"),
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            onDismissed: (direction) {
                              setState(() {
                                tasks.removeAt(index);
                              });
                            },
                            child: AnimatedContainer(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 5),
                              duration: const Duration(milliseconds: 600),
                              decoration: BoxDecoration(
                                color: tasks[index].isCompleted
                                    ? AppColors.primaryColor.withOpacity(0.3)
                                    : AppColors.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                onTap: () {
                                  // Toggle completion status
                                  setState(() {
                                    tasks[index].isCompleted =
                                        !tasks[index].isCompleted;
                                  });
                                },
                                leading: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0.1, bottom: 30),
                                  child: TaskWidget(
                                    task: tasks[index],
                                    onToggle: (isCompleted) {
                                      // Update task status
                                      setState(() {
                                        tasks[index].isCompleted = isCompleted;
                                      });
                                    },
                                  ),
                                ),
                                title: Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 2, top: 6),
                                  child: Text(
                                    tasks[index].title,
                                    style: TextStyle(
                                      color: tasks[index].isCompleted
                                          ? AppColors.buttonColor
                                          : AppColors.textColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      decoration: tasks[index].isCompleted
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tasks[index].description,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: tasks[index].isCompleted
                                            ? AppColors.buttonColor
                                            : AppColors.textColor,
                                        fontWeight: FontWeight.w300,
                                        decoration: tasks[index].isCompleted
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10, top: 10),
                                        child: Column(
                                          children: [
                                            Text(
                                              tasks[index].atTime.toString(),
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: AppColors.textColor,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                            Text(
                                              tasks[index].atDate.toString(),
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  color: AppColors.textColor,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Lottie.asset(
                          'assets/lottie/check.json',
                          width: 300,
                          height: 300,
                          fit: BoxFit.fill,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
