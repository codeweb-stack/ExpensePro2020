import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

List<Transaction> tnxListFromJson(String str) => List<Transaction>.from(
    json.decode(str).map((x) => Transaction.fromJson(x)));
Transaction tnxFromJson(String str) => Transaction.fromJson(json.decode(str));
String tnxToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
  int id;
  String title;
  double amount;
  DateTime date;

  Transaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});
  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
      id: int.parse(json['Id']),
      title: json['Title'],
      amount: double.parse(json['Amount']),
      date: DateTime.parse(json["Date"]));

  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "Amount": amount,
        "Date": DateFormat('yyyy-MM-dd').format(date),
      };
}
