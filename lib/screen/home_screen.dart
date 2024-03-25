import 'package:aromtoyproject/model/task.dart';
import 'package:aromtoyproject/screen/add_task_screen.dart';
import 'package:aromtoyproject/services/theme_services.dart';
import 'package:aromtoyproject/ui/theme.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  final box = Hive.box('myBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: customAppBar(context),
      body: Column(children: [
        addDateBar(),
        showTask(),
      ]),
    );
  }

  AppBar customAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          //테마변경
          Get.isDarkMode
              ? Icons.wb_sunny_outlined
              : Icons.nightlight_round_outlined,
          size: 24,
          color: Get.isDarkMode ? Colors.white : darkGreyClr,
        ),
        onPressed: () {
          ThemeServices().switchTheme();
        },
      ),
      elevation: 0, //그림자 깊이
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTaskScreen(),
                  ));
            },
            icon: Icon(Icons.add)),
      ],
    );
  }

  addDateBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10, top: 10),
      child: DatePicker(
        DateTime.now(),
        width: 80,
        height: 100,
        initialSelectedDate: selectedDate,
        selectedTextColor: Colors.white,
        selectionColor: primaryClr,
        dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        )),
        dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        )),
        monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        )),
        onDateChange: (newDate) {
          setState(() {
            selectedDate = newDate;
          });
        },
      ),
    );
  }

  Future<void> _onRefresh() async {
    setState(() {});
  }

  showTask() {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemBuilder: (context, index) {
            Task loadTask = box.getAt(index);
            if (DateFormat('yyyy-MM-dd').format(loadTask.date) ==
                DateFormat('yyyy-MM-dd').format(selectedDate)) {
              return taskView(loadTask);
            } else {
              return null;
            }
          },
          itemCount: box.length,
        ),
      ),
    );
  }

  taskView(Task task) {
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
                  SizedBox(
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
