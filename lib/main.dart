import 'package:flutter/material.dart';

import '../widgets/transactionList.dart';
import '../widgets/new_transaction.dart';
import './models/transaction.dart';
import '../widgets/chart.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //     id: "t1", title: "New Shoe", amount: 10.99, date: DateTime.now()),
    // Transaction(
    //     id: "t2",
    //     title: "Weekly Groceries",
    //     amount: 69.99,
    //     date: DateTime.now()),
  ];

  List<Transaction> get _recenTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(String txTitle, String txAmount, DateTime txDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: double.parse(txAmount),
        date: txDate);

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      elevation: 5,
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.deferToChild,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id==id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        // errorColor: Colors.red,
        fontFamily: "Qicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
              fontFamily: "OpenSans",
              fontWeight: FontWeight.bold,
              fontSize: 15,
            )),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 20,
                ),
              ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Personal Expense"),
          actions: <Widget>[
            Builder(
              builder: (context) => IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: Icon(Icons.add),
                // color: Colors.white),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Chart(_userTransaction),
              TransactionList(_userTransaction,_deleteTransaction),
            ],
          ),
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            // backgroundColor: FloatingActionButtonThemeData.lerp(2, 3, 5),
            child: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
