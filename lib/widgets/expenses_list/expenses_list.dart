import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    required this.expenses,
    required this.removeExpense,
    super.key,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expenses[index].id),
        background: Container(color: Theme.of(context).colorScheme.error),
        child: ExpenseItem(expense: expenses[index]),
        onDismissed: (direction) {
          removeExpense(expenses[index]);
        },
      ),
    );
  }
}
