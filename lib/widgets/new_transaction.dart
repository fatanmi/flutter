import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function handleAddNewTransaction;

  NewTransaction(this.handleAddNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime _selectedDate=DateTime.now() ;

  void submitData() {
    
    if (_titleController.text.isEmpty ||
        double.parse( _amountController.text ) <= 0 ) {
      return;
    }
    widget.handleAddNewTransaction(
        _titleController.text, _amountController.text,_selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker(BuildContext ctx) {
    showDatePicker(
      context: ctx,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      _selectedDate = pickedDate;
      print(_selectedDate.toString());
    });
  }

  // void _deleteTransaction(String id){
  //   setState(() {
  //     _user
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(4),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: _titleController,
              keyboardType: TextInputType.text,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    _selectedDate == null
                        ? "No date Chosen"
                        : DateFormat.yMd().format(
                            _selectedDate,
                          ),
                  ),
                  FlatButton(
                    onPressed: () {
                      _presentDatePicker(context);
                    },
                    child: Text(
                      "Choose Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                  ),
                  // DatePickerDialog(initialDate: initialDate, firstDate: firstDate, lastDate: lastDate),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: submitData,
              child: Text(
                "Add Transaction",
              ),
              // textColor: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
}
