// ignore_for_file: import_of_legacy_library_into_null_safe, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transacion.dart';

import 'package:intl/date_symbol_data_local.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(
      {Key? key, required this.transactions, required this.onRemove})
      : super(key: key);

  final List<Transaction> transactions;

  final void Function(String) onRemove;
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);
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
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                          child: Text(
                        'R\$${tr.value}',
                        style: const TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    DateFormat('d MMM y', "pt_BR").format(tr.data),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.black,
                    onPressed: () => onRemove(tr.id),
                  ),
                ),
              );
            },
          );
  }
}
