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

  List<List> pages = [];
  bool canPop = true;

  String title = "Lists";

  @override
  void initState() {
    super.initState();
    currentScreen = ToDoMain(changePage: changePage);
    pages.add(["Lists", currentScreen]);
  }

  void changePage(String newTitle, Widget screen) {
    setState(() {
      title = newTitle;
      currentScreen = screen;
      pages.add([newTitle, currentScreen]);
    });
  }



  @override
  Widget build(BuildContext context) {

    canPop = pages.length > 1 ? false : true;

    return PopScope(
      canPop: canPop,
      onPopInvoked: (flag){
        pages.remove(pages.last);
        changePage(pages.last[0], pages.last[1]);


        print([pages.last[0], pages.last[1]]);
        print(pages);
      },
      child: Scaffold(
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
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 200), // Продолжительность анимации
              transitionBuilder: (Widget child, Animation<double> animation) {
                const begin = Offset(2.0, 0.0); // Начальная позиция (справа)
                const end = Offset.zero; // Конечная позиция (центр)
                const curve = Curves.ease; // Тип кривой анимации

                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
              child: currentScreen, // Текущий экран, который нужно отобразить
            )
            ,
          ),
        ),
      ),
    );
  }

}
