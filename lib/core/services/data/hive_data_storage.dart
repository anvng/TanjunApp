import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tanjun_app/modules/models/task_model.dart';

// CRUD using Hive Database
class HiveDataStorage {
  // box name - string
  static const boxName = 'TaskBox';
  late Box<TaskModel> box;

  // constructor
  HiveDataStorage() {
    _openBox();
  }

  // open box
  Future<void> _openBox() async {
    box = await Hive.openBox<TaskModel>(boxName);
  }

  // save data inside box
  Future<void> addTask({required TaskModel task}) async {
    await box.add(task);
  }

  // show task
  Future<TaskModel?> getTasks({required String id}) async {
    return box.get(id);
  }

  // update task
  Future<void> updateTask({required TaskModel task}) async {
    await box.put(task.id, task);
  }

  // delete task
  Future<void> deleteTask({required TaskModel task}) async {
    await box.delete(task.id);
  }

  // listen to box changes
  ValueListenable<Box<TaskModel>> listenToTask() => box.listenable();
}
