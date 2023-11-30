import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:lab_3_todo/ParseEvents.dart';

class ToDoList extends StatefulWidget {
  // late Future<String> test;
  ToDoList({super.key});



  @override
  State<ToDoList> createState() {
    // late Future<String> test;
    return _ToDoListState();
  }
}

class _ToDoListState extends State<ToDoList> with WidgetsBindingObserver {
  late Future<String> json;
  Map<String, List<Map<String, bool>>> groupedEvents = {};

  @override
  void initState() {
    super.initState();
    json = ParseEvents.readEvents();
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
    ParseEvents.writeEventsToFile(jsonEncode(groupedEvents));
  }

  @override
  void dispose() {
    ParseEvents.writeEventsToFile(jsonEncode(groupedEvents));
    super.dispose();
    print("dispose");

  }

  @override
  Widget build(BuildContext context) {

    Icon doneIcon = Icon(Icons.circle, size: 15.0, color: Color.fromRGBO(6, 187, 108, 1));
    Icon unDoneIcon = Icon(Icons.circle_outlined, size: 15.0, color: Color.fromRGBO(66, 72, 82, 1));

    void changeGroupedEvents(List<String> a){

      setState(() {
        groupedEvents[a[0]]?.forEach((element) {
          if (element.keys.single == a[1]){
            element.update(a[1], (value) => value ? false : true);
          }
        });
      });
      ParseEvents.writeEventsToFile(jsonEncode(groupedEvents));
    }

    return FutureBuilder(
      future: json,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Показывай индикатор загрузки
        } else if (snapshot.hasError) {
          return Text('Ошибка: ${snapshot.error}');
        } else {
          groupedEvents = groupedEvents.isEmpty ?
          createMap(json: snapshot.data) : groupedEvents;
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


                          return InkWell(
                            onTap: () => changeGroupedEvents([entry.key,task.keys.first]),
                            splashColor: Colors.red,
                            focusColor: Colors.red,
                            hoverColor: Colors.red,
                            highlightColor: Colors.red,
                            radius: 1,

                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
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
      },

    );
  }


}

Map<String, List<Map<String, bool>>> createMap({String json = ""}){

  Map<String, List<Map<String, bool>>> test = {
    '17 Января': [{'Купить морковь': true}, {'Сходить к доктору, 17:40': false}, {'Позвонить маме...': true}],
    '18 Января': [{'Пора переехать': true}],
    '19 Января': [{'Отправть кроссовки обратно': false}, {'Купить билеты в Париж!!!': true}],
    '20 Января': [{'Работать': false}],
    '21 Января': [{'Работать': false}],
  };
  json = json.isEmpty ? jsonEncode(test) : json;

  var decodedJson = jsonDecode(json);

  // Преобразование в нужный тип
  Map<String, List<Map<String, bool>>> decoded = decodedJson.map<String, List<Map<String, bool>>>( (key, value) {
      String stringKey = key; // ДАТА
      List list = value; // ЗАДАЧА:ФЛАГ
      return MapEntry( // МАПАЕМ
          stringKey, // ДАТА
          list.map<Map<String, bool>>((item) {
            // ЗАДАЧА:ФЛАГ
            return Map<String, bool>.from(item as Map);
          }).toList());
    },
  );

  print(decoded);
  return decoded;
}





