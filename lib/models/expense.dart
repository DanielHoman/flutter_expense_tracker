import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

final DateFormat formatter = DateFormat('yyyy.MM.dd.');

enum Category { food, travel, leisure, work }

const Map<Category, IconData> categoryIcons = {
  Category.food: Icons.fastfood,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}
