import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/expense.dart';

final formater = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final _textController = TextEditingController();
  final _textAmountController = TextEditingController();
  Categories _selectedCategory = Categories.leisure;
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text('Invalid input'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Okay'),
                )
              ],
              content: const Text(
                  'Please make valid title, amount, date are entered.'),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Invalid input'),
              icon: const Icon(Icons.warning),
              iconColor: Colors.redAccent,
              alignment: Alignment.centerLeft,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Okay'),
                )
              ],
              content: const Text(
                  'Please make valid title, amount, date are entered.'),
            );
          });
    }
  }

  void _submitExpenseData() {
    final amount = double.tryParse(_textAmountController.text.trim());
    final amountIsInvalid = amount == null || amount <= 0;
    if (_textController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }
    widget.onAddExpense(Expense(
        title: _textController.text.trim(),
        amount: amount,
        date: _selectedDate!,
        category: _selectedCategory));
  }

  @override
  void dispose() {
    _textController.dispose();
    _textAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (context, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          maxLength: 50,
                          decoration: InputDecoration(
                            label: Text(
                              'Title',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _textAmountController,
                          decoration: const InputDecoration(
                            prefix: Text('\$'),
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _textController,
                    maxLength: 50,
                    decoration: InputDecoration(
                      label: Text(
                        'Title',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                          value: _selectedCategory,
                          items: Categories.values.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value.name.toUpperCase(),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'No date Selected'
                                : formater.format(_selectedDate!),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month),
                          )
                        ],
                      ))
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _textAmountController,
                          decoration: const InputDecoration(
                            prefix: Text('\$'),
                            label: Text('Amount'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'No date Selected'
                                : formater.format(_selectedDate!),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month),
                          )
                        ],
                      ))
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (width < 600)
                      DropdownButton(
                          value: _selectedCategory,
                          items: Categories.values.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value.name.toUpperCase(),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          }),
                    ElevatedButton(
                      onPressed: () {
                        _submitExpenseData();
                      },
                      child: const Text('Save Expense'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
