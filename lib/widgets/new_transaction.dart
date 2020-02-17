import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  
  // String titleInput;
  // String amountInput;

  final titleController = TextEditingController();
  final amountController = TextEditingController();


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
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            // onChanged: (val) => amountInput = val,
            controller: amountController,
          ),
          FlatButton(
            onPressed: () {
              print(titleController);
              print(amountController);
            },
            child: Text('Transaction'),
            color: Colors.purple,
          )
        ],
      ),
    );
  }
}
