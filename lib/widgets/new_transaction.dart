import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransaction;

  NewTransaction(this._addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget._addNewTransaction(enteredTitle, enteredAmount);

    Navigator.of(context).pop(); // daje nam to możliwość zamknięcia okna nadrzędnego
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            // onChanged: (val) { // w miejsce wal mozna wstawic cokolwiek
            //  titleInput = val;
            // },
            controller: titleController,
            onSubmitted: (_) => submitData(), // dzieki onSubmitted: gdy uzytkownik kliknie w przycisk Gotowe na klawiaturze dane zostana dodane, gdy spalniaja warunki funkcji itp.
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            // onChanged: (val) => amountInput = val,
            controller: amountController,
            keyboardType: TextInputType.number, // gdy uzytkownik kliknie w pole tekstowe pokaze mu sie klawiatura numeryczna
            onSubmitted: (_) => submitData(), // (_) taka funkcje anonimowa mozemy dodac, kiedy chcemy wykonac funkcje anonimowa, lecz nie interesuja nas dane ktore dostajemy wczesniej
          ),
          FlatButton(
            onPressed: submitData,
            child: Text('Transaction'),
            color: Colors.purple,
          )
        ],
      ),
    );
  }
}
