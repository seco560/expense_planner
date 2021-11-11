/// Model class which represents an expense/transaction
class ExpenseTransaction {
  final String id;
  final String title;
  final double price;
  final DateTime timestamp;

  ExpenseTransaction({
    required this.id,
    required this.title,
    required this.price,
    required this.timestamp,
  });

  @override
  String toString() {
    return 'Transaction $id | Title: $title | Price: $price | Timestamp: $timestamp';
  }
}
