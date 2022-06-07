// ignore_for_file: import_of_legacy_library_into_null_safe, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transacion.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({Key? key, required this.transactions})
      : super(key: key);

  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              Text(
                "Nenhuma transação cadastrada.",
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 20),
              Container(
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : ListView.builder(
            //!Habilitando o carregamento por necessidade só carrega na tela se for necessário
            itemCount: transactions.length, //!Definindo o máximo de registro
            //!Configurando o builder para criar sobre demanda
            itemBuilder: (context, index) {
              final tr = transactions[index];
              return Card(
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.purple,
                          width: 2,
                        ),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'R\$ ${tr.value}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.purple),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tr.title,
                            style: Theme.of(context)
                                .textTheme
                                .headline6), //Pegando estilo do tema padrão
                        Text(
                          DateFormat('d MMM y').format(tr.data),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
  }
}
