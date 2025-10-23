import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';
import 'package:expense_tracker/app_theme.dart';
//import 'package:flutter/services.dart';

void main() {
  final AppTheme appTheme = AppTheme();
  /* WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    value,
  ) { */
  runApp(
    MaterialApp(
      darkTheme: appTheme.getTheme(Brightness.dark),
      theme: appTheme.getTheme(Brightness.light),
      themeMode: ThemeMode.system,
      home: Expenses(),
    ),
  );
  //});
}
