import 'package:expense_planner/models/expense_transaction.dart';
import 'package:expense_planner/widgets/transaction_widget.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatefulWidget {
  const TransactionList(this._userTransactions, {Key? key}) : super(key: key);
  final List<ExpenseTransaction> _userTransactions;

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget._userTransactions.length,
      itemBuilder: (BuildContext ctx, int index) {
        return TransactionWidget(widget._userTransactions[index]);
      },
    );
  }
}
