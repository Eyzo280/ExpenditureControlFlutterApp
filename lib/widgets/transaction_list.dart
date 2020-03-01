import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function deleteTx;

  TransactionList(this._userTransactions, this.deleteTx);
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
                SizedBox(
                  // Pusta przestrzen dzieki ktorej mozemy dawac odstepy
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'images/waiting.png',
                    fit: BoxFit.cover,
                  ), // Dzieki fit: BoxFit.cover przyjmuje wysokosc Container czyli 200
                )
              ],
            )
          : ListView.builder(
              itemCount: _userTransactions.length,
              itemBuilder: (ctx, index) {
                return Container(
                  padding: EdgeInsets.all(5),
                  child: Card(
                    child: ListTile(
                      leading: Container(
                          height: 50,
                          width: 50,
                          child: CircleAvatar(
                            child: Text(
                              _userTransactions[index].amount.toString(),
                            ),
                          )),
                      title: Text(
                        _userTransactions[index].title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(DateFormat('yyy-MM-dd')
                          .format(_userTransactions[index].date)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () {
                          deleteTx(_userTransactions[index].id);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
