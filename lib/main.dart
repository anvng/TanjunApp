import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tanjun_app/core/services/data/hive_data_storage.dart';
import 'package:tanjun_app/modules/models/task_model.dart';
import 'package:tanjun_app/modules/views/home_screen.dart';

Future<void> main() async {
  // initialize hive
  await Hive.initFlutter();

  // register hive adapters
  Hive.registerAdapter<TaskModel>(TaskModelAdapter());

  // open box
  var box = await Hive.openBox<TaskModel>('task_box');

  // delete tasks from the previous day
  _deleteOldTasks(box);

  // run app
  runApp(BaseWidget(child: const TanjunApp()));
}

void _deleteOldTasks(Box<TaskModel> box) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);

  for (var task in box.values) {
    final taskDate =
        DateTime(task.atTime.year, task.atTime.month, task.atTime.day);
    if (taskDate.isBefore(today)) {
      task.delete();
    }
  }
}

class BaseWidget extends InheritedWidget {
  BaseWidget({super.key, required this.child}) : super(child: child);
  final HiveDataStorage dataStorage = HiveDataStorage();

  @override
  final Widget child;

  @override
  bool updateShouldNotify(covariant BaseWidget oldWidget) {
    return oldWidget.dataStorage != dataStorage;
  }

  static BaseWidget of(BuildContext context) {
    final base = context.dependOnInheritedWidgetOfExactType<BaseWidget>();
    if (base != null) {
      return base;
    } else {
      throw Exception('No BaseWidget found in context');
    }
  }
}

class TanjunApp extends StatelessWidget {
  const TanjunApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tanjun App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
