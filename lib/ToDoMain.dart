import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_3_todo/ToDoList.dart';

class ToDoMain extends StatefulWidget {

  @override
  State<ToDoMain> createState() => _ToDoMainState();
}

class _ToDoMainState extends State<ToDoMain> {

  String title = "Lists";
  List<List> blocks = [
    [0, 8, "Today"],
    [1, 15, "This week"],
    [1, 36, "All"],
    [0, 2, "Completed"],
  ];
  bool isMain = true;

  void changeTitle(String newTitle) {
    setState(() {
      title = newTitle;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppBar(
          backgroundColor: Colors.transparent,
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
        // createLists(blocks, changeTitle),
        ToDoList(),
      ],
    );
  }
}

Expanded createLists(List blocks, Function(String) changeTitle){
  return Expanded(
    child: GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.6,
      crossAxisSpacing: 6,
      mainAxisSpacing: 12,

      children: getAllLists(blocks, changeTitle),
    ),

  );
}

List<Widget> getAllLists(List arr, Function(String) changeTitle){
  List<Widget> lists = [];

  arr.forEach((e) {
    lists.add(getList(e, changeTitle));
  });

  return lists;
}

Widget getList(List arr, Function(String) changeTitle){
  int type = arr[0];
  int num = arr[1];
  String descr = arr[2];

  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: GestureDetector(
      onTap: () => changeTitle(descr),
      child: Container(
          color: type == 0 ? Color.fromRGBO(6, 187, 108, 1) :
          Color.fromRGBO(36,36,51, 1),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    num.toString(),
                    style: TextStyle(
                        color: type == 0 ? Colors.white : Color.fromRGBO(119, 132, 150, 1),
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    descr.toString(),
                    style: TextStyle(
                        color: type == 0 ? Colors.white :
                        Color.fromRGBO(119, 132, 150, 1),
                        fontSize: 15,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    ),
  );
}