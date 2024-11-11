import 'package:expense_tracker/data/hive_database.dart';
import 'package:expense_tracker/dateTime/date_time_helper.dart';
import 'package:expense_tracker/models/expense_items.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier{
  //list of all expenses
  List<ExpenseItem> overallExpenseList = [];

  //getting the expense list
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  //prepare data to display
  final db = HiveDatabase();
  void prepareData(){
    if(db.readData().isNotEmpty){
      overallExpenseList =db.readData();
    }
  }

  //adding new new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  //deleting any expenses
  void deleteExpenseList(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  //getting week day
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'MON';
      case 2:
        return 'TUE';
      case 3:
        return 'WED';
      case 4:
        return 'THU';
      case 5:
        return 'FRI';
      case 6:
        return 'SAT';
      case 7:
        return 'SUN';
      default:
        return '';
    }
  }

//get the date from start of the week
    DateTime startOfWeekDate(){
    DateTime? startOfWeek;


    //getting today's date
    DateTime today = DateTime.now();

    //finding nearest sunday
     for(int i =0; i<7; i++){
       if(getDayName(today.subtract(Duration(days: i)))== 'SUN'){
         startOfWeek = today.subtract(Duration(days: i));
       }
     }
     return startOfWeek!;
    }

//overall expense data list converting into daily expense list

//calculating summary of each day

  Map<String, double>calculateDailyExpenseSummary(){
    Map<String,double> dailyExpenseSummary ={
      //date(yyyymmdd) : amount total for a day
    };

    for ( var expense in overallExpenseList){
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if(dailyExpenseSummary.containsKey(date)){
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      }else{
        dailyExpenseSummary.addAll({date: amount});
      }
    }
      return dailyExpenseSummary;
  }
}
