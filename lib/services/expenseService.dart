import 'package:flutter/material.dart';
import '../models/transaction.dart';

class ExpenseService {
  static const String filePath = "assets/Json/myexpenses.json";

  static Future<List<Transaction>> getTnxs(BuildContext ctx) async {
    final String expensesJson =
        await DefaultAssetBundle.of(ctx).loadString(filePath);
    final List<Transaction> tnxs = tnxListFromJson(expensesJson);
    return tnxs;
  }
}
