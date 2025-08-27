import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/models/category_model.dart';

class EventModel {
  String id;

  CategoryModel category;
  String title;
  String description;
  DateTime dateTime;

  EventModel({
    this.id = "",
    required this.category,
    required this.title,
    required this.description,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category.id,
    "title": title,
    "description": description,
    "timestamp": Timestamp.fromDate(dateTime),
  };

  EventModel.fromJson(Map<String, dynamic> json)
    : this(
        id: json["id"],
        category: CategoryModel.categories.firstWhere(
          (category) => category.id == json["category"],
        ),
        title: json["title"],
        description: json["description"],

        dateTime: (json["timestamp"] as Timestamp).toDate(),
      );
}
