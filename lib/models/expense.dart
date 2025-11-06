import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final DateFormat formatter = DateFormat('yyyy.MM.dd.');

enum ExpCategory { food, travel, leisure, work }

const Map<ExpCategory, IconData> categoryIcons = {
  ExpCategory.food: Icons.fastfood,
  ExpCategory.travel: Icons.flight,
  ExpCategory.leisure: Icons.movie,
  ExpCategory.work: Icons.work,
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
  final ExpCategory category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
    : expenses = allExpenses
          .where((element) => element.category == category)
          .toList();

  final ExpCategory category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
