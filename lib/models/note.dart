import 'package:flutter/material.dart';

class Note {
  Note({
    this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.color,
  });

  int? id;
  String title;
  String description;
  DateTime date;
  Color color;

  factory Note.fromJson(Map<String, dynamic> json) {
    String valueString = json['color'].split('(0x')[1].split(')')[0];
    int value = int.parse(valueString, radix: 16);
    Color otherColor = Color(value);
    return Note(
      id: json['id'],
      color: otherColor,
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'color': color.toString(),
      'date': date.toIso8601String(),
    };
  }
}
