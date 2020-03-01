import 'package:expenditure_control_flutterapp/widgets/chart.dart';

import './widgets/new_transaction.dart';

import './widgets/transaction_list.dart';

import './models/transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand', // globalna czcionka
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          // zmienia TextStyle tytulu w appBar
          textTheme: TextTheme(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 15,
            ),
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosendate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosendate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        // umożliwia to zrobienie okna ktore jest nadrzedne nad innymi widgetami
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      // jezeli uzujemy where to gdy nastepny return zwroci true to element zostanie dodany do listy
      return tx.date.isAfter(DateTime.now().subtract(Duration(
          days:
              7))); // tak jest dobrze ale mozna zrobic w ten sposob > tx.date.isAfter(DateTime.now().substract(Duration(days: 7))) dzieki temu zapisowi dostajemy cala date krotsza o 7 dni
    }).toList(); // bez .toList() jest blad Iterable
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => startNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerFloat, // wysrodkowanie przycisku plywajacego
      floatingActionButton: FloatingActionButton(
        // przycisk plywajacy
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context)
            .accentColor, // Theme.of(context).accentColor oznacza ze pobiera alternatywny kolor z Theme
        onPressed: () => startNewTransaction(context),
      ),
    );
  }
}
