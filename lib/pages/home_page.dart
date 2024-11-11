import 'package:expense_tracker/components/expense_summary.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Text controllers
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();
  final cardController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  // Method to show dialog and add new expense
  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "Add a new expense",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Expense name input
              TextField(
                controller: newExpenseNameController,
                decoration: InputDecoration(
                    hintText: "Expense Name",
                    hintStyle: TextStyle(color: Colors.grey[500])),
              ),
              // Expense amount input
              TextField(
                controller: newExpenseAmountController,
                decoration: InputDecoration(
                    hintText: "Expense Amount",
                    hintStyle: TextStyle(color: Colors.grey[500])),
                keyboardType: TextInputType.number,
              ),
              // Card used input
              TextField(
                controller: cardController,
                decoration: InputDecoration(
                    hintText: "Card Used",
                    hintStyle: TextStyle(color: Colors.grey[500])),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Save button
                MaterialButton(
                  onPressed: save,
                  child: const Text(
                    "Save",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                // Cancel button
                MaterialButton(
                  onPressed: cancel,
                  child: const Text(
                    "Cancel",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  // Method to save the expense
  void save() {
    // Check if all required fields are filled
    if (newExpenseNameController.text.isEmpty ||
        newExpenseAmountController.text.isEmpty ||
        cardController.text.isEmpty) {

      // Show an alert or a snackbar to inform the user
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all the fields"))
      );
      return; // Prevent saving if any field is empty
    }

    // If all fields are filled, create a new ExpenseItem
    ExpenseItem newExpense = ExpenseItem(
      dateTime: DateTime.now(),
      amount: newExpenseAmountController.text,
      name: newExpenseNameController.text,
      cardUsed: cardController.text,
    );

    // Add the new expense to the list
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);

    // Close the dialog
    Navigator.pop(context);
    clear(); // Clear the fields after saving
  }

  // Method to cancel adding an expense
  void cancel() {
    Navigator.pop(context);
    clear();
  }

  // Method for clearing the text fields
  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
    cardController.clear();
  }

  // Delete expenses
  void deleteExpense(ExpenseItem expense) {
    // Call delete method in your provider
    Provider.of<ExpenseData>(context, listen: false).deleteExpenseList(expense);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, right: 10, left: 10),
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Consumer<ExpenseData>(
          builder: (context, value, child) {
            return ListView(
              children: [
                // Weekly summary (Bar Graph)
                ExpenseSummary(startOfWeek: value.startOfWeekDate()),
                const SizedBox(height: 20),

                // "Expenses: " text label
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Expenses: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Space between label and expense list

                // Expense List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: value.getAllExpenseList().length,
                  itemBuilder: (context, index) {
                    ExpenseItem expense = value.getAllExpenseList()[index];
                    return ExpenseTile(
                      name: expense.name,
                      amount: expense.amount,
                      dateTime: expense.dateTime,
                      cardUsed: expense.cardUsed,
                      deleteTapped: (BuildContext context) {
                        deleteExpense(expense);
                      },
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
