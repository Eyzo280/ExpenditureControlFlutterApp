import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransaction;

  NewTransaction(this._addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget._addNewTransaction(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context)
        .pop(); // daje nam to możliwość zamknięcia okna nadrzędnego
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            // onChanged: (val) { // w miejsce wal mozna wstawic cokolwiek
            //  titleInput = val;
            // },
            controller: _titleController,
            onSubmitted: (_) =>
                _submitData(), // dzieki onSubmitted: gdy uzytkownik kliknie w przycisk Gotowe na klawiaturze dane zostana dodane, gdy spalniaja warunki funkcji itp.
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            // onChanged: (val) => amountInput = val,
            controller: _amountController,
            keyboardType: TextInputType
                .number, // gdy uzytkownik kliknie w pole tekstowe pokaze mu sie klawiatura numeryczna
            onSubmitted: (_) =>
                _submitData(), // (_) taka funkcje anonimowa mozemy dodac, kiedy chcemy wykonac funkcje anonimowa, lecz nie interesuja nas dane ktore dostajemy wczesniej
          ),
          Container(
            height: 70,
            child: Row(
              children: <Widget>[
                Expanded( // dzieki temu widget zajmuje tyle miejsca ile moze
                  child: Text(_selectedDate == null
                      ? 'Date'
                      : DateFormat('dd/MM/yyy').format(_selectedDate)),
                ),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    _presentDatePicker();
                  },
                  child: Text(
                    'Select Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          RaisedButton(
            onPressed: _submitData,
            child: Text('Transaction'),
            textColor: Theme.of(context).textTheme.button.color,
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}
