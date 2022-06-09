// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, import_of_legacy_library_into_null_safe, library_private_types_in_public_api, library_prefixes

import 'dart:math';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'components/chart.dart';
import 'components/transaction_list.dart';
import 'models/transacion.dart';

import 'package:timezone/data/latest.dart' as tzMain;

main() {
  WidgetsFlutterBinding.ensureInitialized();
  tzMain.initializeTimeZones();
  runApp(ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        textTheme: tema.textTheme.copyWith(
          // Definindo o Headline padrão do tema
          headline6: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          button: TextStyle(
            color: Colors.white,
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  // = [
  //   Transaction(
  //     id: 'T1',
  //     title: "TST1",
  //     value: 310.76,
  //     data: tz.TZDateTime.now(tz.getLocation('America/Sao_Paulo'))
  //         .subtract(Duration(days: 3)),
  //   ),
  //   Transaction(
  //     id: 'T2',
  //     title: "TST2",
  //     value: 211.30,
  //     data: tz.TZDateTime.now(tz.getLocation('America/Sao_Paulo'))
  //         .subtract(Duration(days: 4)),
  //   ),
  //   Transaction(
  //     id: 'T2',
  //     title: "TST3",
  //     value: 400.00,
  //     data: tz.TZDateTime.now(tz.getLocation('America/Sao_Paulo'))
  //         .subtract(Duration(days: 50)),
  //   ),
  //   Transaction(
  //     id: 'T2',
  //     title: "TST4",
  //     value: 409.00,
  //     data: tz.TZDateTime.now(tz.getLocation('America/Sao_Paulo')),
  //   ),
  // ];

  List<Transaction> get _recentTransaction {
    return _transactions.where((transaction) {
      return transaction.data.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addTransaction(String title, double value, DateTime selectedDate) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        data: selectedDate);
    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.pop(context);
  }

  void _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void _openTransactinFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return TransactionForm(onSubmit: _addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Despesa Pessoais",
          ),
          actions: [
            IconButton(
              onPressed: () => _openTransactinFormModal(context),
              icon: Icon(Icons.add),
            ),
          ]),
      body: Column(
        children: [
          Chart(
            recentTransaction: _recentTransaction,
          ),
          Expanded(
              child: TransactionList(
            transactions: _transactions,
            onRemove: _removeTransaction,
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactinFormModal(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
