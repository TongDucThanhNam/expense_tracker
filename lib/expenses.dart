import 'package:expense_tracker/expenses_list.dart';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:flutter/material.dart';

import 'models/expense.dart';
import 'new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerExpenses = [
    Expense(
      title: "Flutter course",
      amount: 1,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Eat",
      amount: 6,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      title: "Chick",
      amount: 2,
      date: DateTime.now(),
      category: Category.travel,
    ),
  ];

  void _addNewExpense(Expense expense) {
    setState(() {
      _registerExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registerExpenses.indexOf(expense);

    setState(() {
      _registerExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(
        content: const Text("Expense deleted"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registerExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ));
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpense(
            addNewExpense: _addNewExpense,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;



    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("ExpenseTracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Expanded(child: Chart(expenses: _registerExpenses)),
                if (_registerExpenses.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        "No expenses yet",
                      ),
                    ),
                  )
                else
                  Expanded(
                    flex: 1,
                    child: ExpensesList(
                      expenses: _registerExpenses,
                      removeExpense: _removeExpense,
                    ),
                  )
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registerExpenses)),
                if (_registerExpenses.isEmpty)
                  const Expanded(
                    child: Center(
                      child: Text(
                        "No expenses yet",
                      ),
                    ),
                  )
                else
                  Expanded(
                    flex: 1,
                    child: ExpensesList(
                      expenses: _registerExpenses,
                      removeExpense: _removeExpense,
                    ),
                  )
              ],
            ),
    );
  }
}
