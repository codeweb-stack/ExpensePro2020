import 'package:flutter/material.dart';
import '../utils/coolors.dart';

class AddTransaction extends StatefulWidget {
  // const AddTransaction({Key key}) : super(key: key);
  final Function addTx;
  AddTransaction({this.addTx});

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final titlecontroller = TextEditingController();

  final amountcontroller = TextEditingController();

  void submitData() {
    final inputTitle = titlecontroller.text;
    final inputAmount = double.parse(amountcontroller.text);
    if (inputTitle.isEmpty || inputAmount <= 0) {
      return;
    }
    widget.addTx(inputTitle, inputAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: AppColors.orangeRedCrayola,
                        fontWeight: FontWeight.w500),
                    labelText: 'Title',
                    fillColor: Colors.indigo),
                cursorColor: Colors.indigo,
                controller: titlecontroller,
                keyboardType: TextInputType.text,
                onSubmitted: (title) => submitData(),
                // onChanged: (title) {
                //   titlelisten = title;
                // },
              ),
              TextField(
                decoration: InputDecoration(
                    labelStyle: TextStyle(
                        color: AppColors.orangeRedCrayola,
                        fontWeight: FontWeight.w500),
                    labelText: 'Amount',
                    prefixText: '\u{20B9} '),
                controller: amountcontroller,
                keyboardType: TextInputType.number,
                onSubmitted: (amount) => submitData(),
                // onChanged: (amount) {
                //   amountlisten = amount;
                // },
              ),
              FlatButton(
                  color: AppColors.orangeRedCrayola,
                  textColor: Colors.white,
                  onPressed: submitData,
                  child: Text('Add Transaction'))
            ],
          ),
        ),
      ),
    );
  }
}
