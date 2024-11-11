Expense Tracker App
An easy-to-use mobile app to help you track your daily, weekly, and monthly expenses. This app is designed to give you a clear view of where your money goes, featuring interactive charts, expense categories, and detailed transaction lists.

Features
Add Expenses: Quickly add new expenses with name, amount, and payment method.
Weekly Summary: Visualize your weekly expenses with a bar chart to track your spending habits.
Expense List: View a list of all your recorded expenses with details.
Data Management: Edit, delete, and manage your expenses efficiently.
Dark & Light Theme: Choose between themes to suit your preference.
Screenshots

Technologies Used
Flutter - For building the cross-platform mobile app.
Provider - For state management.
Hive - For local database
SQLite (optional) - Local database for offline data storage.
Getting Started
Prerequisites
Install Flutter SDK.
Basic knowledge of Dart and Flutter is recommended.
Installation
Clone the repository:

bash
Copy code
git clone https://github.com/your-username/expense-tracker.git
cd expense-tracker
Install dependencies:

bash
Copy code
flutter pub get
Run the app:

bash
Copy code
flutter run
File Structure
plaintext
Copy code
lib/
├── components/            # Reusable components like ExpenseTile, ExpenseSummary
├── data/                  # Provider and data handling files
├── models/                # Models such as ExpenseItem
├── screens/               # Screens like HomePage, AddExpensePage
└── main.dart              # Main entry point of the application
Usage
Adding an Expense
Click on the floating Add button on the main screen.
Enter the expense details: name, amount, and payment method.
Click Save to add the expense to your list.
Deleting an Expense
Swipe an expense item in the list to delete it or use the delete icon in the expense tile.
Viewing Weekly Summary
The weekly summary chart shows your expenses per day, giving a clear overview of your spending patterns.
Customization
You can customize the app to fit your needs. For example:

Themes: Modify the app's theme settings in the ThemeData section in main.dart.
Backend Integration: This app uses Firebase (optional) for backend, but you can replace it with another solution like SQLite for local storage.
Contributing
Contributions are welcome! To contribute:

Fork the project.
Create a feature branch (git checkout -b feature/new-feature).
Commit your changes (git commit -m 'Add new feature').
Push to the branch (git push origin feature/new-feature).
Open a Pull Request.
License
This project is licensed under the MIT License. See the LICENSE file for more information.

