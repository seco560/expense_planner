import 'package:expense_planner/widgets/transaction_container.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExpensePlannerMainView());
}

// TODO Split up widgets and have a stateful one handle input
class ExpensePlannerMainView extends StatelessWidget {
  const ExpensePlannerMainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.purple,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Expenses Planner"),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(4.0),
          children: const <Widget>[
            Card(
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
            TransactionsContainer(),
          ],
        ),
      ),
    );
  }
}
