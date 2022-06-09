// ignore_for_file: prefer_const_constructors_in_immutables, library_private_types_in_public_api, sort_child_properties_last, unused_field, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  TransactionForm({Key? key, required this.onSubmit}) : super(key: key);

  final void Function(String title, double value, DateTime selectedDate)
      onSubmit;

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _monetaryValueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_monetaryValueController.text) ?? 0.0;
    final selectedDate = _selectedDate;
    if (title.isEmpty || value <= 0 || selectedDate == null) {
      return; //Caso o form esteja invalido -> Finaliza a função
    }
    //!Executando a função que recebemos por parametro do componente pai.
    //!Executando o método que foi recebido por herança do StatefulWidget -> Método que só existia na classe Stateful
    //!Mas com a herança ele fica disponivel dentro do estado. -> widget.
    widget.onSubmit(title, value, selectedDate);
    //! Limpando controllers
    _titleController.clear();
    _monetaryValueController.clear();
  }

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Título'),
              controller: _titleController,
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Valor (R\$)'),
              onSubmitted: (_) => _submitForm(),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              controller: _monetaryValueController,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate != null
                        ? 'Data Selecionada: ${DateFormat('dd/MM/yyyy', "pt_BR").format(_selectedDate)}'
                        : "Nenhuma data selecionada.",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: _showDatePicker,
                  child: Text('Selecionar Data',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary)),
                )
              ],
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
                  ),
                  style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shadowColor: Theme.of(context).colorScheme.primary,
                      elevation: 5,
                      textStyle: Theme.of(context).textTheme.button),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
