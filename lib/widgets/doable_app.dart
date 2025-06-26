import 'package:doable_todo_list_app/screens/add_task_page.dart';
import 'package:doable_todo_list_app/screens/home_page.dart';
import 'package:doable_todo_list_app/screens/settings_page.dart';
import 'package:flutter/material.dart';

class DoableApp extends StatelessWidget {
  const DoableApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        fontFamily: "Inter",
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.w900,
            color: Color(0xff0c120c),
          ),
          displayMedium: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Color(0xff0c120c),
          ),
          displaySmall: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
            color: Color(0xff0c120c),
          ),
          labelSmall: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
            color: Color(0xff565656),
          ),
          bodyLarge: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            color: Color(0xff0c120c),
          ),
          bodyMedium: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Color(0xff565656),
          ),
          bodySmall: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Color(0xff565656),
          ),
        ),
      ),
      initialRoute: 'home',
      routes: {
        'home': (context) => const HomePage(),
        'add_task': (context) => const AddTaskPage(),
        'settings': (context) => const SettingsPage(),
        // ⚠️ 'edit_task' route is removed
      },
    );
  }
}
