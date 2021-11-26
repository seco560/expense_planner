import 'package:expense_planner/widgets/add_transaction_widget.dart';
import 'package:expense_planner/widgets/transaction_list_widget.dart';
import 'package:flutter/material.dart';

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
  void addNewExpense(BuildContext ctx) {
    // create and increment id
    String id = 't' +
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
            const Expanded(
              flex: 1,
              child: Card(
                color: Colors.purple,
                margin: EdgeInsets.all(22.0),
                child: Text(
                  "Chart - Placeholder",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                elevation: 5,
              ),
            ),
            Expanded(flex: 8, child: TransactionList(_userTransactions)),
          ],
        ),
      ),
    );
  }
}
