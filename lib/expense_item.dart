import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem(this.expense, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(
            expense.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("\$ ${expense.amount.toStringAsFixed(2)}"),
              Row(
                children: [
                  Icon(expense.getIconCategory),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(expense.formatedDatetime)
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
