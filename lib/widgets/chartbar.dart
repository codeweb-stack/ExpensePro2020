import 'package:ExpensePro2020/utils/coolors.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double totalpct;
  ChartBar({this.label, this.amount, this.totalpct});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(child: Text(label))),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            width: 10,
            height: constraints.maxHeight * 0.6,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 1, color: AppColors.robinEggBlue),
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.corn),
                ),
                FractionallySizedBox(
                  heightFactor: totalpct,
                  child: Container(
                    decoration: BoxDecoration(
                        // border:
                        //     Border.all(width: 1, color: AppColors.robinEggBlue),
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.orangeRedCrayola),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Text('\u{20B9}${amount.toStringAsFixed(0)}')))
        ],
      );
    });
  }
}
