import 'package:expense_planner/widgets/add_transaction_widget.dart';
import 'package:expense_planner/widgets/transaction_chart.dart';
import 'package:expense_planner/widgets/transaction_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'models/expense_transaction.dart';

void main() {
  runApp(const ExpensePlannerMainView());
}

class ExpensePlannerMainView extends StatefulWidget {
  const ExpensePlannerMainView({Key? key}) : super(key: key);

  @override
  State<ExpensePlannerMainView> createState() => _ExpensePlannerMainViewState();
}

class _ExpensePlannerMainViewState extends State<ExpensePlannerMainView> {
  final List<ExpenseTransaction> _userTransactions = [
    ExpenseTransaction(
      id: 't0',
      title: 'Eee PC',
      price: 300,
      timestamp: DateTime(2010, 11, 28),
    ),
    ExpenseTransaction(
      id: 't1',
      title: 'Pocophone',
      price: 1200,
      timestamp: DateTime(2021, 11, 30),
    ),
    ExpenseTransaction(
      id: 't2',
      title: 'PSVita',
      price: 350.70,
      timestamp: DateTime(2021, 12, 6),
    ),
  ];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  List<ExpenseTransaction> get _recentTransactions {
    return _userTransactions
        .where((transaction) => transaction.timestamp
            .isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  // text controllers, they get passed down to the add transaction widget
  // we need them here to more easily retrieve the text value (see below)
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  /// Void callback that gets passed to addTransactionWidget
  /// Creates a new object and modifies state to reflect its addition
  void addNewExpense(BuildContext ctx) {
    // create and increment id
    String id = _userTransactions.isEmpty
        ? 't0'
        : 't' +
            (int.parse(_userTransactions.last.id.substring(1)) + 1).toString();
    String title = titleController.text;
    double price = double.parse(priceController.text);
    DateTime timestamp = DateTime.now();

    // create and add transaction to list
    final ExpenseTransaction newTransaction = ExpenseTransaction(
      id: id,
      title: title,
      price: price,
      timestamp: timestamp,
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });

    // clear text and exit modal bottom sheet
    titleController.clear();
    priceController.clear();
    Navigator.pop(ctx);
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet<dynamic>(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      isScrollControlled: true,
      context: ctx,
      builder: (ctx) => Wrap(
        children: <Widget>[
          Padding(
            padding: MediaQuery.of(ctx).viewInsets,
            child: Container(
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
              ),
              child: AddTransactionWidget(
                titleController: titleController,
                priceController: priceController,
                addTransactionCallback: () => addNewExpense(ctx),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expenses Tracker",
      debugShowCheckedModeBanner: false,
      color: Colors.purple,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Expenses Tracker"),
          centerTitle: true,
        ),
        floatingActionButton: Builder(
          builder: (ctx) => FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => startAddNewTransaction(ctx),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          children: <Widget>[
            TransactionChart(recentTransactions: _recentTransactions),
            _userTransactions.isEmpty
                ? const Text('No transactions added yet.')
                : Expanded(flex: 8, child: TransactionList(_userTransactions)),
          ],
        ),
      ),
    );
  }
}
