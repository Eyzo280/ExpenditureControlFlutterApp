import 'package:expenditure_control_flutterapp/models/transaction.dart';
import 'package:expenditure_control_flutterapp/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);
/*
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalsum;

      for (var i = 0; i < _recentTransactions.length; i++) {
        if (_recentTransactions[i].date.day == weekDay.day &&
            _recentTransactions[i].date.month == weekDay.month &&
            _recentTransactions[i].date.year == weekDay.year) {
              totalsum += _recentTransactions[i].amount;
            }
      }

      print(DateFormat.E().format(weekDay));
      print(totalsum);

      return {'day': DateFormat.E().format(weekDay), 'amount': totalsum};
    });
  }
*/

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      var weekDay = DateTime.now().subtract(
        Duration(
            days:
                index), // dzieki temu zapisowi dostajemy cala date krotsza o ilosc dni index
      );
      var totalsum = 0.0;

      for (var i = 0; i < _recentTransactions.length; i++) {
        if (_recentTransactions[i].date.day == weekDay.day &&
            _recentTransactions[i].date.month == weekDay.month &&
            _recentTransactions[i].date.year == weekDay.year) {
          totalsum += _recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalsum,
      };
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) /
                        totalSpending, // to oznacza ze gdy wartosc totalSpending bedzie rowna 0.0 to wysyla do chartbar 0.0 a gdy wartosc bedzie inna to wykonuje (data['amount'] itp. bez tego warunku bedzie blad, gdyz bedzie chcialo dzielic przez 0.0
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
