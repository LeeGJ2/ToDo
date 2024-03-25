import 'package:aromtoyproject/model/task.dart';
import 'package:aromtoyproject/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aromtoyproject/ui/theme.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox('myBox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
