import 'package:ExpensePro2020/utils/coolors.dart';
import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double totalpct;
  ChartBar({this.label, this.amount, this.totalpct});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label),
        SizedBox(
          height: 4,
        ),
        Container(
          width: 10,
          height: 60,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: AppColors.robinEggBlue),
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
          height: 4,
        ),
        FittedBox(child: Text('\u{20B9}${amount.toStringAsFixed(0)}'))
      ],
    );
  }
}
