import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formater = DateFormat.yMd();

enum Categories { food, travel, work, leisure }

final categoryIcons = {
  Categories.food: Icons.lunch_dining,
  Categories.work: Icons.work,
  Categories.travel: Icons.travel_explore,
  Categories.leisure: Icons.movie,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = const Uuid().v4();

  final String title;
  final double amount;
  final Categories category;
  final String id;
  final DateTime date;
  final categoryIcons = {
    Categories.food: Icons.lunch_dining,
    Categories.work: Icons.work,
    Categories.travel: Icons.travel_explore,
    Categories.leisure: Icons.movie,
  };

  String get formatedDate {
    return formater.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Categories category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final exp in expenses) {
      sum += exp.amount;
    }
    return sum;
  }
}
