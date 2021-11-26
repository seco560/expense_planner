import 'package:flutter/material.dart';

class AddTransactionWidget extends StatelessWidget {
  const AddTransactionWidget({
    Key? key,
    required this.titleController,
    required this.priceController,
    required this.addTransactionCallback,
  }) : super(key: key);

  final TextEditingController titleController;
  final TextEditingController priceController;
  final VoidCallback addTransactionCallback;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              onChanged: (String value) {},
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
              ),
              keyboardType: TextInputType.number,
              onChanged: (String value) {},
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: ElevatedButton(
                onPressed: addTransactionCallback,
                style: ElevatedButton.styleFrom(primary: Colors.green[700]),
                child: const Text(
                  'Add Transaction',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
