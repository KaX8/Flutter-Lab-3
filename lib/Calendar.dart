import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lab_3_todo/ToDoAdd.dart';
import 'package:lab_3_todo/ToDoList.dart';
import 'package:lab_3_todo/ToDoMain.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});


  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _currentDate = DateTime.now();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = _currentDate;
  }

  List<Widget> _buildDaysName() {
    return ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс']
        .map((day) => Expanded(child: Center(child: Text(day))))
        .toList();
  }

  List<Widget> _buildCalendarDays(DateTime date) {
    List<Widget> dayWidgets = [];
    DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);
    int firstWeekdayOfMonth = firstDayOfMonth.weekday % 7;
    DateTime lastDayOfLastMonth = firstDayOfMonth.subtract(Duration(days: firstWeekdayOfMonth));

    for (var i = 0; i < 35; i++) {
      DateTime day = lastDayOfLastMonth.add(Duration(days: i));

      BoxDecoration decoration;
      TextStyle textStyle;

      if (day.month != _currentDate.month) {
        textStyle = TextStyle(color: Colors.white);
      } else if (day.isAtSameMomentAs(_selectedDate)) {
        decoration = BoxDecoration(color: Colors.blue, shape: BoxShape.circle);
        textStyle = TextStyle(color: Colors.white);
      } else if (day.isAtSameMomentAs(_currentDate)) {
        decoration = BoxDecoration(border: Border.all(color: Colors.blue));
      }

      dayWidgets.add(
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() {
              _selectedDate = day;
            }),
            child: Container(
              child: Center(
                child: Text(
                  DateFormat('d').format(day),
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return dayWidgets;
  }

  List<Row> _buildCalendar() {
    List<Row> calendarRows = [];
    List<Widget> weekDays = _buildDaysName();
    calendarRows.add(Row(children: weekDays));

    for (var i = 0; i < 5; i++) {
      var weekDays = _buildCalendarDays(_currentDate).sublist(i * 7, (i + 1) * 7);
      calendarRows.add(Row(children: weekDays));
    }

    return calendarRows;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(36,36,51, 1),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    _currentDate = DateTime(_currentDate.year, _currentDate.month - 1);
                  });
                },
              ),
              Text(DateFormat('MMMM y').format(_currentDate), style: TextStyle(color: Colors.white),),
              IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    _currentDate = DateTime(_currentDate.year, _currentDate.month + 1);
                  });
                },
              ),
            ],
          ),
          ..._buildCalendar(),
        ],
      ),
    );
  }
}
