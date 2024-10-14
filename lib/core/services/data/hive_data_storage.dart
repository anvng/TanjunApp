import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tanjun_app/modules/models/task_model.dart';

// CRUD using Hive Database
class HiveDataStorage {
  // Box name
  static const boxName = 'TaskBox';
  late Box<TaskModel> box;

  // Singleton instance
  static final HiveDataStorage _instance = HiveDataStorage._internal();

  // Private constructor
  HiveDataStorage._internal();

  // Factory constructor
  factory HiveDataStorage() {
    return _instance;
  }

  // Initialize and open the box
  Future<void> init() async {
    await _openBox();
  }

  // Open box
  Future<void> _openBox() async {
    try {
      box = await Hive.openBox<TaskModel>(boxName);
    } catch (e) {
      // Handle errors
      debugPrint('Error opening box: $e');
    }
  }

  // Save data inside box
  Future<void> addTask({required TaskModel task}) async {
    await box.add(task);
  }

  // Show task by index
  Future<TaskModel?> getTask({required int index}) async {
    if (index < 0 || index >= box.length) {
      debugPrint('Invalid index: $index');
      return null;
    }
    return box.getAt(index);
  }

  // Get all tasks
  Future<List<TaskModel>> getAllTasks() async {
    return box.values.toList();
  }

  // Update task
  Future<void> updateTask({required int index, required TaskModel task}) async {
    if (index < 0 || index >= box.length) {
      debugPrint('Invalid index: $index');
      return;
    }
    await box.putAt(index, task);
  }

  // Delete task
  Future<void> deleteTask({required int index}) async {
    if (index < 0 || index >= box.length) {
      debugPrint('Invalid index: $index');
      return;
    }
    await box.deleteAt(index);
  }

  // Delete all tasks
  Future<void> deleteAllTasks() async {
    await box.clear();
  }

  // Listen to box changes
  ValueListenable<Box<TaskModel>> listenToTasks() => box.listenable();
}
