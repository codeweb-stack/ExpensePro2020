import 'package:flutter/material.dart';
import '../utils/coolors.dart';
import 'package:intl/intl.dart';

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

  DateTime _selectedDate;

  void submitData() {
    final inputTitle = titlecontroller.text;
    final inputAmount = double.parse(amountcontroller.text);
    if (inputTitle.isEmpty || inputAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(inputTitle, inputAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _choseData() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      } else {
        setState(() {
          _selectedDate = value;
        });
      }
    });
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
              Container(
                height: 50,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'Date not chosen yet!'
                          : DateFormat.yMMMMd().format(_selectedDate)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                        onPressed: _choseData,
                        child: Text('Chose Date'),
                        // color: AppColors.orangeRedCrayola,
                        textColor: AppColors.robinEggBlue,
                      ),
                    ),
                  ],
                ),
              ),
              RaisedButton(
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
