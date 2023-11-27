import 'package:flutter/material.dart';

class Task{

  final String mainText;
  final String subText;
  final bool checked;
  final bool favorite;
  final String time;
  final Widget w;

  Task(this.mainText, this.subText, this.checked, this.w, this.time, this.favorite);
}