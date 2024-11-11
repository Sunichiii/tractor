import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  final String cardUsed;
  final void Function(BuildContext)? deleteTapped;

  const ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.cardUsed,
    required this.deleteTapped, // Pass the callback to the constructor
  });

  @override
  Widget build(BuildContext context) {
    // Convert hour to 12-hour format and determine AM/PM
    int hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    String period = dateTime.hour >= 12 ? 'PM' : 'AM';

    // Handle edge case for midnight (12 AM)
    if (hour == 0) {
      hour = 12;
    }

    // Format for the time with 12-hour format and AM/PM
    String timeString = '$hour:${dateTime.minute.toString().padLeft(2, '0')} $period';

    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              // Trigger the delete action when pressed
              if (deleteTapped != null) {
                deleteTapped!(context);
              }
            },
            icon: Icons.delete,
            backgroundColor: Colors.red,
            //label: 'Delete',
            borderRadius: BorderRadius.circular(5),
            
          )
        ],
      ),
      child: ListTile(
        title: Text(
          name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${dateTime.day}/${dateTime.month}/${dateTime.year}', // Date in dd/mm/yyyy format
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Time: $timeString', // Time in 12-hour format with AM/PM
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '\$$amount',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              cardUsed,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
