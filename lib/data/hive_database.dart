import 'package:expense_tracker/models/expense_items.dart';
import 'package:hive/hive.dart';

class HiveDatabase {
  // Reference to the box
  final _myBox = Hive.box("expenses_database");

  // Save data
  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime.toIso8601String(), // Save DateTime as string
        expense.cardUsed,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    _myBox.put("ALL_EXPENSES", allExpensesFormatted); // This line should be inside the method
  }

  // Read data
  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      String dateTimeString = savedExpenses[i][2];
      String cardUsed = savedExpenses[i][3];

      // Convert dateTimeString back to DateTime
      DateTime dateTime = DateTime.parse(dateTimeString);

      // Creating ExpenseItem
      ExpenseItem expense = ExpenseItem(
        dateTime: dateTime,
        amount: amount,
        name: name,
        cardUsed: cardUsed,
      );

      allExpenses.add(expense);
    }
    return allExpenses;
  }
}
