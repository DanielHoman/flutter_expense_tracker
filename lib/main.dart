import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';
import 'package:expense_tracker/app_theme.dart';

void main() {
  final AppTheme appTheme = AppTheme();
  runApp(
    MaterialApp(
      darkTheme: appTheme.getTheme(Brightness.dark),
      theme: appTheme.getTheme(Brightness.light),
      themeMode: ThemeMode.system,
      home: Expenses(),
    ),
  );
}
