import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;

  TransactionList(this._userTransactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      //  musimy dodac Container oraz ustawic jego wysokosc, aby moc dodac SingleChildScrollView/ListView, gdyz bez tego SingleChildScrollView/ListView nie wie na jakiej wysokosci moze przewijac widget
      height: 300, //
      child: _userTransactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox( // Pusta przestrzen dzieki ktorej mozemy dawac odstepy
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset('images/waiting.png', fit: BoxFit.cover,), // Dzieki fit: BoxFit.cover przyjmuje wysokosc Container czyli 200
                )
              ],
            )
          : ListView.builder(
              itemCount: _userTransactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context)
                                .primaryColor, // Theme.of(context).primaryColor oznacza ze pobiera podstawowy kolor z Theme
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$${_userTransactions[index].amount.toStringAsFixed(2)}', // dzieki .toStringAsFixed(2) dane wyjsciowe na ekranie sa zawsze z dwoma miejscami po przecinku
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            _userTransactions[index].title,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd')
                                .format(_userTransactions[index].date),
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
