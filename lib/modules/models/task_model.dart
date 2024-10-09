import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.atTime,
    required this.atDate,
    required this.isCompleted,
  });

  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  DateTime atTime;
  @HiveField(4)
  DateTime atDate;
  @HiveField(5)
  bool isCompleted;

  // create a new task
  factory TaskModel.newTask({
    required String? title,
    required String? description,
    required DateTime? atTime,
    required DateTime? atDate,
  }) =>
      TaskModel(
        id: int.parse(const Uuid().v4()),
        title: title ?? '',
        description: description ?? '',
        atTime: atTime ?? DateTime.now(),
        atDate: atDate ?? DateTime.now(),
        isCompleted: false,
      );
}
