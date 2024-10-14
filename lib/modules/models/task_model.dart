import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  // Use late to allow Hive to handle the instantiation.
  @HiveField(0)
  late final String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late DateTime atTime;

  @HiveField(4)
  late DateTime atDate;

  @HiveField(5)
  bool isCompleted;

  TaskModel({
    String? id, // Allow nullable ID to handle updates
    required this.title,
    required this.description,
    required this.atTime,
    required this.atDate,
    this.isCompleted = false,
  }) {
    // Assign a new UUID if no ID is provided (for new tasks)
    this.id = id ?? const Uuid().v4();
  }

  // Factory method for creating new tasks
  factory TaskModel.newTask({
    required String title,
    required String description,
    DateTime? atTime,
    DateTime? atDate,
  }) {
    if (title.trim().isEmpty) {
      throw ArgumentError("Title cannot be empty");
    }

    return TaskModel(
      title: title,
      description: description.trim(),
      atTime: atTime ?? DateTime.now(),
      atDate: atDate ?? DateTime.now(),
    );
  }

  // Optional: Getter for formatted date
  String get formattedAtTime => "${atTime.hour}:${atTime.minute}";

  // Optional: Getter for task status
  String get status => isCompleted ? "Completed" : "Pending";
}
