import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final random = Random();
List<Color> colors = const [
  Color(0XFFFAB090),
  Color(0XFFF9CE7F),
  Color(0XFF78D8E9),
  Color(0XFFE5E9A4),
  Color(0XFFFA9BAF),
  Color(0XFFD09FDB),
];

class Note {
  Note({required this.title, required this.description, required this.date})
      : id = uuid.v4(),
        color = colors[random.nextInt(colors.length)];
  String id;
  String title;
  String description;
  DateTime date;
  Color color;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        title: json['title'],
        description: json['description'],
        date: json['date'],
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'color': color,
    };
  }
}
