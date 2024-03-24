import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:aromtoyproject/ui/theme.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController taskController = TextEditingController();

  DateTime selectedDate = DateTime.now();

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
                    contentPadding: EdgeInsets.symmetric(vertical: 150.0),
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
            ],
          ),
        ),
      ),
      bottomSheet: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(10),
            minimumSize: const Size.fromHeight(50),
          ),
          child: Text(
            '추가하기',
            style: bodyStyle,
          )),
    );
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
}
