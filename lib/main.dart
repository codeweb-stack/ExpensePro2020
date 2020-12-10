import 'package:flutter/material.dart';
import 'package:ExpensePro2020/utils/coolors.dart';
import 'package:ExpensePro2020/widgets/add_transaction.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import './models/transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/chart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final appdir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appdir.path);
  Hive.registerAdapter(TransactionAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
        future: Hive.openBox('transactions'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return MyExpense();
            }
          } else {
            return Scaffold();
          }
        },
      ),
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
  final List<Transaction> _userTransactions = [];

  get len => _userTransactions.length;

  List<Transaction> get _recentTransaction {
    final tnxBox = Hive.box('transactions');
    return tnxBox.values
        .where((element) {
          return element.date
              .isAfter(DateTime.now().subtract(Duration(days: 7)));
        })
        .toList()
        .cast<Transaction>();
  }

  void _addTransaction(String txTitle, double txAmount, DateTime txdDate) {
    Transaction addTx = Transaction(
        id: len + 1, title: txTitle, amount: txAmount, date: txdDate);
    final transactionsBox = Hive.box('transactions');
    transactionsBox.add(addTx);
    setState(() {
      _userTransactions.add(addTx);
    });
  }

  //use less code in case of hive db as watcher is looking for build refresher
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
