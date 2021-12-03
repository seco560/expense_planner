import 'package:expense_planner/models/expense_transaction.dart';
import 'package:expense_planner/widgets/transaction_chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionChart extends StatelessWidget {
  const TransactionChart({required this.recentTransactions, Key? key})
      : super(key: key);

  final List<ExpenseTransaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'totalSum': recentTransactions
            .where((transaction) =>
                transaction.timestamp.day == weekDay.day &&
                transaction.timestamp.month == weekDay.month &&
                transaction.timestamp.year == weekDay.year)
            .fold(
                0.0,
                (previousValue, transaction) =>
                    double.parse(previousValue.toString()) + transaction.price)
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(
        0.0,
        (previousValue, element) =>
            previousValue + (element['totalSum'] as num));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: groupedTransactionValues
            .map((data) => Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      data['day'] as String,
                      data['totalSum'] as double,
                      totalSpending == 0
                          ? 0
                          : (data['totalSum'] as double) / totalSpending),
                ))
            .toList()
            .reversed
            .toList(),
      ),
    );
  }
}
