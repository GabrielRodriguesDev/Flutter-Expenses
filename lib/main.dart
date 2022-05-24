// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:expenses/models/transacion.dart';
import 'package:flutter/material.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final _transacions = [
    Transsaction(
      id: 't1',
      title: 'Novo tênis de corrida.',
      value: 310.76,
      data: DateTime.now(),
    ),
    Transsaction(
      id: 't1',
      title: 'Novo tênis de corrida.',
      value: 211.30,
      data: DateTime.now(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Despesa Pessoais"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Card(
              elevation: 5,
              child: Text("Gráfico"),
            ),
          ),
          Card(
            elevation: 5,
            child: Text("Lista de Transações"),
          )
        ],
      ),
    );
  }
}
