
import 'package:aromtoyproject/services/theme_services.dart';
import 'package:aromtoyproject/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: customAppBar(),
      body: Column(children: [
        Text('list'),
      ]),
    );
  }
}


AppBar customAppBar() {
  return AppBar(
    leading: IconButton(
      icon: Icon( //테마변경
        Get.isDarkMode?Icons.wb_sunny_outlined : Icons.nightlight_round_outlined,
        size : 24,
        color : Get.isDarkMode ? Colors.white : darkGreyClr,
      ),
      onPressed: () {
        ThemeServices().switchTheme();
      },
    ),
    elevation: 0, //그림자 깊이
    actions: [
      IconButton(onPressed: () {
        
      }, 
      icon: Icon(Icons.add)),
    ],
  );
}