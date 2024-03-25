import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:aromtoyproject/ui/theme.dart';

import '../model/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController taskController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  final box = Hive.box('myBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Text(
                  '일정 추가',
                  style: titleStyle,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '제목',
                      style: subTitleStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: '제목을 입력하세요',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '내용',
                      style: subTitleStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: taskController,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 100.0),
                      labelText: '내용을 입력하세요',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      '날짜',
                      style: subTitleStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  canRequestFocus: false,
                  decoration: InputDecoration(
                    labelText: DateFormat('yyyy-MM-dd').format(selectedDate),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.date_range_outlined),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2015),
                          lastDate: DateTime(2050),
                          initialDate: selectedDate,
                        );

                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        canRequestFocus: false,
                        decoration: InputDecoration(
                            labelText: startTime,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.watch_later_outlined),
                              onPressed: () =>
                                  getTimeFromUser(isStartTime: true),
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: TextFormField(
                        canRequestFocus: false,
                        decoration: InputDecoration(
                            labelText: endTime,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.watch_later_outlined),
                              onPressed: () =>
                                  getTimeFromUser(isStartTime: false),
                            )),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        bottomSheet: addTaskButton());
  }

  addTaskButton() {
    return ElevatedButton(
        onPressed: () {
          if (titleController.text.toString().isEmpty ||
              taskController.text.toString().isEmpty) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (context) {
                return AlertDialog(
                  content: Text('제목과 내용은 필수 사항입니다.'),
                  actions: [
                    Center(
                      child: ElevatedButton(
                        child: Icon(Icons.check, size: 12),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  ],
                );
              },
            );
            return;
          }

          Task task = Task(
              title: titleController.text.toString(),
              task: taskController.text.toString(),
              isCompleted: 0,
              date: selectedDate,
              startTime: startTime,
              endTime: endTime);

          box.put(task.id, task);
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(10),
          minimumSize: const Size.fromHeight(50),
        ),
        child: Text(
          '추가하기',
          style: bodyStyle,
        ));
  }

  getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
      initialDate: selectedDate,
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15))),
    );
    if (pickedTime == null) return;
    // ignore: use_build_context_synchronously
    String formattedTime = pickedTime!.format(context);

    if (isStartTime) {
      setState(() => startTime = formattedTime);
    } else if (!isStartTime) {
      setState(() => endTime = formattedTime);
    } else {
      print('Something went wrong !');
    }
  }
}
