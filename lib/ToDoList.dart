import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  Map<String, List<Map<String, bool>>> groupedEvents = {
    '17 January': [{'Buy groceries': true}, {'Book doctor\'s appointment': false}, {'Call mom': true}],
    '18 January': [{'Prepare for move': true}],
    '19 January': [{'Send back shoes': false}, {'Buy Bon Iver tickets': true}],
  };

  @override
  Widget build(BuildContext context) {
    Icon doneIcon = Icon(Icons.circle, size: 15.0, color: Color.fromRGBO(6, 187, 108, 1));
    Icon unDoneIcon = Icon(Icons.circle_outlined, size: 15.0, color: Color.fromRGBO(66, 72, 82, 1));

    void changeGroupedEvents(List<String> a){
      groupedEvents.map((key, value) => {

      });
    }

    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(
          color: Color.fromRGBO(36,36,51, 1),
          width: double.infinity,

          child: ListView(
            children: groupedEvents.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Text(
                      entry.key,
                      style: TextStyle(
                        color: Color.fromRGBO(66, 72, 82, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  ...entry.value.map((task) {

                    String taskText = task.keys.first;
                    bool done = bool.parse(task.values.first.toString());


                    return ElevatedButton(
                      onPressed: () => test([entry.key,task.keys.first]),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(36,36,51, 1)),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                        child: Row(
                          children: [
                            done ? doneIcon : unDoneIcon,
                            SizedBox(width: 10.0),
                            Text(
                              task.keys.first,
                              style: TextStyle(
                                color: Color.fromRGBO(119, 132, 150, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}


