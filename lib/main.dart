import 'package:ExpensePro2020/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyExpense(),
      title: 'My Expense',
    );
  }
}

class MyExpense extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        id: 1, title: 'buy jacket', amount: 3524.46, date: DateTime.now()),
    Transaction(id: 2, title: 'buy book', amount: 1140.24, date: DateTime.now())
  ];
  // String titlelisten;
  // String amountlisten;
  final titlecontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('My Expense'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Container(
          //   height: MediaQuery.of(context).size.height / 4,
          // ),
          Column(
              children: transactions.map((e) {
            return Card(
              child: Row(
                children: <Widget>[
                  Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.blueGrey)),
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                      child: Row(
                        children: [
                          Text(
                            '\u{20B9} ${e.amount.toString()}',
                            style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        e.title.toUpperCase(),
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(DateFormat.yMMMMd().format(e.date),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.blueGrey[200],
                          ))
                    ],
                  )
                ],
              ),
            );
          }).toList()),
          Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Title', fillColor: Colors.indigo),
                    cursorColor: Colors.indigo,
                    controller: titlecontroller,
                    // onChanged: (title) {
                    //   titlelisten = title;
                    // },
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'Amount', prefixText: '\u{20B9} '),
                    controller: amountcontroller,
                    // onChanged: (amount) {
                    //   amountlisten = amount;
                    // },
                  ),
                  FlatButton(
                      color: Colors.indigo,
                      textColor: Colors.white,
                      onPressed: () {
                        // print(titlelisten);
                        // print(amountlisten);
                        print(titlecontroller.text);
                        print(amountcontroller.text);
                      },
                      child: Text('Add Transaction'))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
