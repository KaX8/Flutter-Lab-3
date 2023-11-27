import 'package:flutter/material.dart';
import 'package:lab_3_todo/ToDoList.dart';
import 'package:lab_3_todo/ToDoMain.dart';

class ToDoBase extends StatefulWidget {
  const ToDoBase({super.key});


  @override
  State<ToDoBase> createState() => _ToDoBaseState();
}

class _ToDoBaseState extends State<ToDoBase> {



  Widget currentScreen = ToDoMain();

  void navigateToScreen(Widget screen) {
    setState(() {
      currentScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(26,26,38,1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: currentScreen,
        ),
      ),
    );
  }

}
