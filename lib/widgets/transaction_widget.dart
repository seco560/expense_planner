import 'package:expense_planner/models/expense_transaction.dart';
import 'package:flutter/material.dart';

/// Widget that takes one expense transaction object and nicely displays it
class TransactionWidget extends StatelessWidget {
  const TransactionWidget(this.transaction, {Key? key}) : super(key: key);

  final ExpenseTransaction transaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shadowColor: Colors.purple,
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.all(6.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CircleAvatar(
              minRadius: 28,
              backgroundColor: Colors.green.shade700,
              foregroundColor: Colors.white,
              child: Text(
                '${transaction.price.toStringAsFixed(2)}\nRON',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade200,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // over the top date manipulation
                  Text(
                    transaction.timestamp
                        .toIso8601String()
                        .split('T')[0] // remove time
                        .split('-') // separate Y/M/D
                        .reversed // turn it around
                        .fold(
                            '',
                            (String previousValue, String element) =>
                                previousValue + '.' + element)
                        // recombine with periods
                        .substring(1), // trim first period
                  ),
                ],
              ),
            ),
            const SizedBox(width: 30),
          ],
        ),
      ),
    );
  }
}
