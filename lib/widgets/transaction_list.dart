import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:recase/recase.dart';
import '../utils/coolors.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletetnx;
  TransactionList({@required this.transactions, this.deletetnx});
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 550,
        // ignore: deprecated_member_use
        child: WatchBoxBuilder(
          box: Hive.box('transactions'),
          builder: (context, transactions) {
            return ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tnx = transactions.getAt(index) as Transaction;
                return Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.lightGray, width: 2.0)),
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: ListTile(
                    tileColor: AppColors.ivory,
                    leading: CircleAvatar(
                      backgroundColor: AppColors.orangeRedCrayola,
                      foregroundColor: AppColors.ivory,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child:
                              Text('\u{20B9} ${tnx.amount.toStringAsFixed(2)}'),
                        ),
                      ),
                    ),
                    title: Text(
                      tnx.title.titleCase,
                      style: TextStyle(
                          fontSize: 18, color: AppColors.robinEggBlue),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd().format(tnx.date),
                      style: TextStyle(
                        fontSize: 16,
                        // fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_forever_rounded),
                      onPressed: () {
                        transactions.deleteAt(index);
                        deletetnx(index + 1);
                      },
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}

// return Card(
//   color: AppColors.ivory,
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       Container(
//           margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//           decoration: BoxDecoration(
//               border: Border.all(width: 2, color: AppColors.corn)),
//           padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
//           child: Row(
//             children: [
//               Text(
//                 '\u{20B9} ${transactions[index].amount.toStringAsFixed(2)}',
//                 style: TextStyle(
//                     color: AppColors.robinEggBlue,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold),
//               ),
//             ],
//           )),transactions[index].title.titleCase,
//       Container(
//         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: <Widget>[
//             Text(
//               transactions[index].title.titleCase,
//               style: TextStyle(
//                   fontSize: 16,
//                   color: AppColors.robinEggBlue,
//                   fontWeight: FontWeight.w500),
//             ),
//             Text(DateFormat.yMMMMd().format(transactions[index].date),
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: AppColors.lightGray,
//                 ))
//           ],
//         ),
//       )
//     ],
//   ),
// );
