import 'package:expense_tracker/expense_item.dart';
import 'package:flutter/material.dart';

import 'models/expense.dart';

class ExpensesList extends StatefulWidget {
  final List<Expense> expenses;
  final Function(Expense expense) removeExpense;

  const ExpensesList(
      {super.key, required this.expenses, required this.removeExpense});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<ExpensesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.expenses.length,
      itemBuilder: (context, index) => Dismissible(
        onDismissed: (direction) {
          widget.removeExpense(widget.expenses[index]);
        },
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
        ),
        key: ValueKey(widget.expenses[index]),
        child: ExpenseItem(widget.expenses[index]),
      ),
    );
  }
}
