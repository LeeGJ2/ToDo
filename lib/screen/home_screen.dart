import 'package:aromtoyproject/model/task.dart';
import 'package:aromtoyproject/screen/add_task_screen.dart';
import 'package:aromtoyproject/services/theme_services.dart';
import 'package:aromtoyproject/ui/task_tile.dart';
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
                  )).then((value) {
                setState(() {});
              });
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
            final Task loadTask = box.getAt(index);
            bool res = ((DateFormat('yyyy-MM-dd').format(loadTask.date)) ==
                (DateFormat('yyyy-MM-dd').format(selectedDate)));
            return TaskTile(loadTask, selectedDate);
          },
          itemCount: box.length,
        ),
      ),
    );
  }
}
