import 'package:flutter/material.dart';
import 'package:lab_3_todo/ToDoList.dart';
import 'package:lab_3_todo/ToDoMain.dart';

class ToDoBase extends StatefulWidget {
  const ToDoBase({super.key});


  @override
  State<ToDoBase> createState() => _ToDoBaseState();
}

class _ToDoBaseState extends State<ToDoBase> {

  late Widget currentScreen;

  String title = "Lists";

  @override
  void initState() {
    super.initState();
    currentScreen = ToDoMain(changeTitle: changeTitle);
  }

  void changeTitle(String newTitle) {
    setState(() {
      title = newTitle;
    });
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Color.fromRGBO(26,26,38,1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: AnimatedSwitcher(
          duration: Duration(milliseconds: 100), // Продолжительность анимации
          child: Text(
            title,
            key: ValueKey<String>(title),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          TextButton(
            style: const ButtonStyle(
              overlayColor: MaterialStatePropertyAll(Color.fromRGBO(6, 187, 108, .3)),
            ),
            onPressed: () {
              print("add");
            },
            child: const Text(
              'ADD',
              style: TextStyle(
                color: Color.fromRGBO(119, 132, 150, 1),
              ),
            ),
          ),
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: currentScreen,
        ),
      ),
    );
  }

}
