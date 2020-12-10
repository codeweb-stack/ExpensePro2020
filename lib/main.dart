import 'package:ExpensePro2020/services/expenseService.dart';
import 'package:ExpensePro2020/utils/coolors.dart';
import 'package:ExpensePro2020/widgets/add_transaction.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/chart.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

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
  List<Transaction> _userTransactions = [];
  get len => _userTransactions.length;

  Future<String> getFilePath() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String appDirPath = appDir.path;
    String filePath = '$appDirPath/myexpense.json';
    return filePath;
  }

  void saveJson(List<Transaction> saveTnx) async {
    File file = File(await getFilePath());
    List<Map> tnxlist = saveTnx.map((e) => e.toJson()).toList();
    file.writeAsString(jsonEncode(tnxlist));
  }

  @override
  void initState() {
    super.initState();
    ExpenseService.getTnxs(context).then((value) {
      _userTransactions = value;
    });
  }

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

  void _save() {
    saveJson(_userTransactions);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: AppColors.orangeRedCrayola,
      title: Text('My Expense'),
      actions: [
        IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _save();
            }),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Container(
            //   height: MediaQuery.of(context).size.height / 4,
            // ),
            Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.28,
                child: Chart(recentTransaction: _recentTransaction)),
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
                : Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.72,
                    child: TransactionList(
                      transactions: _userTransactions,
                      deletetnx: _deleteTransaction,
                    ),
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
