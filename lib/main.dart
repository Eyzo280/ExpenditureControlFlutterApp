import 'package:expenditure_control_flutterapp/widgets/user_transaction.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                child: Text('Chart!'),
                color: Colors.blue,
                elevation: 5, // Wielkosc cienia
              ),
            ),
            UserTransactions()
          ],
        ),
      ),
    );
  }
}
