// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  TransactionForm({Key? key, required this.onSubmit}) : super(key: key);

  final void Function(String title, double value) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final monetaryValueController = TextEditingController();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(monetaryValueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0) {
      return; //Caso o form esteja invalido -> Finaliza a função
    }
    //!Executando a função que recebemos por parametro do componente pai.
    //!Executando o método que foi recebido por herança do StatefulWidget -> Método que só existia na classe Stateful
    //!Mas com a herança ele fica disponivel dentro do estado. -> widget.
    widget.onSubmit(title, value);
    //! Limpando controllers
    titleController.clear();
    monetaryValueController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Título'),
              controller: titleController,
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Valor (R\$)'),
              onSubmitted: (_) => _submitForm(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              controller: monetaryValueController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      _submitForm();
                    },
                    child: const Text(
                      "Nova Transação",
                      style: TextStyle(color: Colors.purple),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
