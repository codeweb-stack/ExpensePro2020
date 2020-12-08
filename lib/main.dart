import 'package:ExpensePro2020/utils/coolors.dart';
import 'package:ExpensePro2020/widgets/add_transaction.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyExpense(),
      title: 'My Expense',
      theme: ThemeData(fontFamily: 'Pacifico'),
      // theme: ThemeData(
      //     primarySwatch: Colors.blueGrey, accentColor: Color(0xFFF5F5DC)),
    );
  }
}

class MyExpense extends StatefulWidget {
  @override
  _MyExpenseState createState() => _MyExpenseState();
}

class _MyExpenseState extends State<MyExpense> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 1,
        title: 'Flying Machine jacket',
        amount: 3524.46,
        date: DateTime.now()),
    Transaction(
        id: 2,
        title: 'Quantum Computing book',
        amount: 1140.24,
        date: DateTime.now())
  ];

  get len => _userTransactions.length;

  List<Transaction> get _recentTransaction {
    return _userTransactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(String txTitle, double txAmount, DateTime txdDate) {
    Transaction addTx = Transaction(
        id: len + 1, title: txTitle, amount: txAmount, date: txdDate);
    setState(() {
      _userTransactions.add(addTx);
    });
  }

  void _startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return AddTransaction(
            addTx: _addTransaction,
          );
        });
  }

  void _deleteTransaction(int id) {
    setState(() {
      _userTransactions.removeAt(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orangeRedCrayola,
        title: Text('My Expense'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _startAddTransaction(context);
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Container(
            //   height: MediaQuery.of(context).size.height / 4,
            // ),
            Chart(recentTransaction: _recentTransaction),
            _userTransactions.isEmpty
                ? Center(
                    child: SizedBox(
                      height: 100,
                      width: 300,
                      child: Column(
                        children: [
                          Icon(
                            Icons.note_add_rounded,
                            color: AppColors.orangeRedCrayola,
                            size: 30,
                          ),
                          Text(
                            'No transactions added yet!',
                            style: TextStyle(color: Colors.black38),
                          )
                        ],
                      ),
                    ),
                  )
                : TransactionList(
                    transactions: _userTransactions,
                    deletetnx: _deleteTransaction,
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.orangeRedCrayola,
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          _startAddTransaction(context);
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}
