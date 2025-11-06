import 'dart:io';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final DateFormat formatter = DateFormat('yyyy.MM.dd.');

class NewExpense extends StatefulWidget {
  const NewExpense({required this.addExpense, super.key});

  final void Function(Expense expense) addExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? _selectedDate;
  ExpCategory _selectedCategory = ExpCategory.leisure;

  Future<void> _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  Future<void> _showDialog() async {
    //! Platform.isIOS Weben nem működik mert a dart:io-hoz nincs hozzáférés
    final bool isIOS;
    if (kIsWeb) {
      isIOS = false;
    } else {
      isIOS = Platform.isIOS;
    }

    if (isIOS) {
      await showCupertinoDialog<void>(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
            'Please make sure a valid title, amount, date and category was entered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
            'Please make sure a valid title, amount, date and category was entered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  void _subbmitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    widget.addExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Widget get titleWidget => TextField(
    controller: _titleController,
    maxLength: 50,
    keyboardType: TextInputType.text,
    decoration: const InputDecoration(label: Text('Title')),
  );

  Widget get amountWidget => Expanded(
    child: TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        prefixText: r'$ ',
        label: Text('Amount'),
      ),
    ),
  );

  Widget get dropdownWidget => DropdownButton(
    value: _selectedCategory,
    items: ExpCategory.values
        .map(
          (category) =>
              DropdownMenuItem(value: category, child: Text(category.name)),
        )
        .toList(),
    onChanged: (value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedCategory = value;
      });
    },
  );

  Widget get dateWidget => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text(
        _selectedDate == null
            ? 'No date selected'
            : formatter.format(
                _selectedDate!,
              ), // "!" azt mondjuk, hogy nem lesz 'null'
      ),
      IconButton(
        onPressed: _presentDatePicker,
        icon: const Icon(Icons.calendar_month),
      ),
    ],
  );

  Widget get cancelWidget => TextButton(
    onPressed: () {
      Navigator.pop(context);
    },
    child: const Text('Cancel'),
  );

  Widget get saveWidget => ElevatedButton(
    onPressed: _subbmitExpenseData,
    child: const Text('Save Expense'),
  );

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: titleWidget),
                        const SizedBox(width: 24),
                        amountWidget,
                      ],
                    )
                  else
                    titleWidget,
                  const SizedBox(height: 8),
                  if (width >= 600)
                    Row(
                      children: [
                        dropdownWidget,
                        const SizedBox(width: 24),
                        dateWidget,
                        const Spacer(),
                        cancelWidget,
                        saveWidget,
                      ],
                    )
                  else
                    Row(
                      children: [
                        amountWidget,
                        const SizedBox(width: 32),
                        dateWidget,
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (width < 600)
                    Row(
                      children: [
                        dropdownWidget,
                        const Spacer(),
                        cancelWidget,
                        saveWidget,
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
