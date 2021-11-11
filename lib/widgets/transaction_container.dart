import 'package:flutter/material.dart';
import 'package:expense_planner/models/expense_transaction.dart';
import 'package:expense_planner/widgets/add_transaction_widget.dart';
import 'package:expense_planner/widgets/transaction_list_widget.dart';

class TransactionsContainer extends StatefulWidget {
  const TransactionsContainer({Key? key}) : super(key: key);

  @override
  _TransactionsContainerState createState() => _TransactionsContainerState();
}

class _TransactionsContainerState extends State<TransactionsContainer> {
  final List<ExpenseTransaction> _userTransactions = [
    ExpenseTransaction(
      id: 't1',
      title: 'Eee PC',
      price: 300,
      timestamp: DateTime(2010, 07, 10),
    ),
    ExpenseTransaction(
      id: 't2',
      title: 'Pocophone',
      price: 1200,
      timestamp: DateTime(2018, 11, 11),
    ),
    ExpenseTransaction(
      id: 't3',
      title: 'PSVita',
      price: 350.70,
      timestamp: DateTime(2020, 11, 11),
    ),
  ];

  // text controllers, they get passed down to the add transaction widget
  // we need them here to more easily retrieve the text value (see below)
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  /// Void callback that gets passed to addTransactionWidget
  /// Creates a new object and modifies state to reflect its addition
  void addNewExpense() {
    // create and increment id
    String id = 't' +
        (int.parse(_userTransactions.last.id.substring(1)) + 1).toString();
    String title = titleController.text;
    double price = double.parse(priceController.text);
    DateTime timestamp = DateTime.now();

    final ExpenseTransaction newTransaction = ExpenseTransaction(
      id: id,
      title: title,
      price: price,
      timestamp: timestamp,
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AddTransactionWidget(
          titleController: titleController,
          priceController: priceController,
          addTransactionCallback: addNewExpense,
        ),
        TransactionList(_userTransactions),
      ],
    );
  }
}
