// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_local_variable

import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transacion.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key, required this.recentTransaction}) : super(key: key);

  final List<Transaction> recentTransaction;

  List<Map<String, String>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().toLocal().subtract(Duration(days: index));

      double totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].data.day == weekDay.day;
        bool sameMonth = recentTransaction[i].data.month == weekDay.month;
        bool sameYear = recentTransaction[i].data.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }

      return {
        'day': DateFormat.E().format(
            weekDay)[0], //Formatando -> Pegando a primeira letra do dia.
        'value': totalSum.toStringAsFixed(2),
      };
    });
  }

  double get _weekTotalValue {
    return groupedTransaction.fold(0.00, (sum, transaction) {
      return sum + double.parse(transaction['value'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransaction;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransaction.map((transaction) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: transaction['day'].toString(),
                value: double.parse(transaction['value'].toString()),
                percentage: double.parse(transaction['value'].toString()) /
                    _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
