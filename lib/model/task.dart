import 'package:hive_flutter/adapters.dart';
import 'package:uuid/uuid.dart';

part 'task.g.dart';

var uuid = const Uuid();

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String task;
  @HiveField(3)
  final int isCompleted;
  @HiveField(4)
  final DateTime date;
  @HiveField(5)
  final String startTime;
  @HiveField(6)
  final String endTime;

  Task(
      {String? id,
      required this.title,
      required this.task,
      required this.isCompleted,
      required this.date,
      required this.startTime,
      required this.endTime})
      : id = id ?? uuid.v4();
}
