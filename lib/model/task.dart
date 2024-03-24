import 'package:hive_flutter/adapters.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? task;
  @HiveField(3)
  int? isCompleted;
  @HiveField(4)
  String? date;

  Task({
    this.id,
    this.title,
    this.task,
    this.isCompleted,
    this.date,
  });
}
