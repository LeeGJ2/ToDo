import 'package:aromtoyproject/model/task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatelessWidget {
  const TaskTile(this.task, this.selectedDate, {Key? key}) : super(key: key);
  final Task task;
  final DateTime selectedDate;
  @override
  Widget build(BuildContext context) {
    if (DateFormat('yyyy-MM-dd').format(task.date) !=
        DateFormat('yyyy-MM-dd').format(selectedDate)) return Container();
    return Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Get.isDarkMode ? Colors.black : Colors.white,
          border: Border.all(
            width: 1.0,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(task.title),
              Text(task.task),
              Row(
                children: [
                  Text(task.startTime),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(task.endTime),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
