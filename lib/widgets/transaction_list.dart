import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';
import '../utils/coolors.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList({@required this.transactions});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1200,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) {
          return Card(
            color: AppColors.ivory,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: AppColors.corn)),
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    child: Row(
                      children: [
                        Text(
                          '\u{20B9} ${transactions[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: AppColors.robinEggBlue,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        transactions[index].title.titleCase,
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.robinEggBlue,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(DateFormat.yMMMMd().format(transactions[index].date),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lightGray,
                          ))
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
