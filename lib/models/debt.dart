import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import "package:intl/intl.dart";

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Category { minus, plus }

const Map categoryIcon = {
  Category.minus: Icons.arrow_downward,
  Category.plus: Icons.arrow_upward
};

class Debt {
  Debt(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final Category category;
  final DateTime date;

  get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket(this.expenses);
  ExpenseBucket.forCategory(List<Debt> allExpenses) : expenses = allExpenses;

  final List<Debt> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum = sum + expense.amount;
    }
    return sum;
  }
}
