class ExpenseModel {
  int? id; // Add id field for SQLite database primary key
  String item;
  int amount;
  bool isIncome;
  DateTime date;

  ExpenseModel({
    this.id, // Add id parameter to constructor
    required this.item,
    required this.amount,
    required this.isIncome,
    required this.date,
  });

  // Convert ExpenseModel object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id, // Add id to the map
      'item': item,
      'amount': amount,
      'isIncome': isIncome ? 1 : 0, // Convert boolean to integer for SQLite
      'date': date.toIso8601String(), // Convert DateTime to ISO 8601 string
    };
  }

  // Create ExpenseModel object from a Map
  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map['id'],
      item: map['item'],
      amount: map['amount'],
      isIncome: map['isIncome'] == 1, // Convert integer to boolean
      date: DateTime.parse(map['date']), // Parse ISO 8601 string to DateTime
    );
  }
}
