import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTransactions;

  TransactionList(this._userTransactions, this._deleteTransactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      child: _userTransactions.isEmpty
          ? Column(
              children: [
                Text(
                  "No transaction added yet!",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    "assests/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ...(_userTransactions
                      .map(
                        (trans) => Card(
                          margin: EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 10,
                          ),
                          elevation: 2,
                          child: ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: FittedBox(
                                    child: Text(
                                        "\$${trans.amount.toStringAsFixed(2)}")),
                              ),
                            ),
                            title: Text(
                              "${trans.title}",
                              style: Theme.of(context).textTheme.title,
                            ),
                            subtitle: Text(
                              DateFormat.yMMMMd('en_US')
                                  .add_jm()
                                  .format(trans.date),
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                _deleteTransactions(trans.id);
                              },
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                            ),
                          ),
                        ),
                      )
                      .toList())
                ],
              ),
            ),
    );
  }
}
