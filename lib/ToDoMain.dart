import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:lab_3_todo/ParseEvents.dart';
import 'package:lab_3_todo/ToDoList.dart';

class ToDoMain extends StatefulWidget {

  final Function(String) changeTitle;
  const ToDoMain ({super.key, required this.changeTitle});



  @override
  State<ToDoMain> createState() => _ToDoMainState(changeTitle);
}

class _ToDoMainState extends State<ToDoMain> {
  final Function(String) changeTitle;
  _ToDoMainState (this.changeTitle);
  late Future<String> json;

  @override
  void initState() {
    super.initState();
    json = ParseEvents.readEvents();
  }


  String title = "Lists";

  bool isMain = true;



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: json,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting){
            return const CircularProgressIndicator();
          }else if(snapshot.hasError){
            return Text("Ошибка ${snapshot.error}");
          }else{

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                createLists(
                    genBlocks(ToDoList.createMap(json: snapshot.data)),
                    changeTitle
                ),
                // ToDoList(json: snapshot.data),
              ],
            );
          }
        }
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

List<List> genBlocks(Map<String, List<Map<String, bool>>> map){
  return [
    getTodayBlock(map),
    getWeekBlock(map),
    getAllTasksBlock(map),
    getCompletedBlock(map),
  ];
}

List getTodayBlock(Map map){
  // DateTime now = DateTime.now();
  DateTime now = DateTime(2023,1,17);
  DateFormat df = DateFormat("y-MM-D");


  return [
    0,
    map[df.format(now)]?.length,
    "Today"
  ];
}

List getWeekBlock(Map map){
  // DateTime now = DateTime.now();
  DateTime now = DateTime(2023,1,17);
  DateFormat df = DateFormat("y-MM-D");
  int countWeekTasks = 0;

  for (int i = 0; i < 7; i++){
    DateTime curr = now.add(Duration(days: i));
    if (map[df.format(curr)]?.length != null) {
      countWeekTasks += map[df.format(curr)].length as int;
    }
  }
  return [
    1,
    countWeekTasks,
    "This week"
  ];
}

List getAllTasksBlock(Map map){
  int countAllTasks = 0;

  map.forEach((key, value) {
    if (map[key]?.length != null) {
      countAllTasks += map[key].length as int;
    }
  });

  return [
    1,
    countAllTasks,
    "All"
  ];
}

List getCompletedBlock(Map map){

  int countCompleted = RegExp(r'true').allMatches(map.toString()).length;
  return [
    0,
    countCompleted,
    "Completed"
  ];
}