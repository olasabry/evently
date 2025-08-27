import 'package:flutter/material.dart';

class CategoryModel {
  String id;
  String name;
  IconData icon;
  String imageName;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.imageName,
  });

  static List<CategoryModel> categories = [
    CategoryModel(
      id: "1",
      name: "sport",
      icon: Icons.sports_basketball_outlined,
      imageName: "sport",
    ),

    CategoryModel(
      id: "2",
      name: "Birthday",
      icon: Icons.cake,
      imageName: "birthday",
    ),

    CategoryModel(
      id: "3",
      name: "meetings",
      icon: Icons.more_time_outlined,
      imageName: "meeting",
    ),
  ];
}
