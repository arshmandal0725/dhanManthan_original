import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import "package:intl/intl.dart";

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Category { food, travel, leisure, work }

const Map<Category, IconData> categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final Category category;
  final DateTime date;

  String get formattedDate {
    return formatter.format(date);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'category': category.toString().split('.').last, // Convert enum to string
    };
  }

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      title: json['title'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      category: Category.values.firstWhere(
        (e) => e.toString().split('.').last == json['category'],
      ),
    );
  }
}

class ExpenseBucket {
  const ExpenseBucket(this.category, this.expenses);
   ExpenseBucket.forCategory(List<Expense> allExpenses,this.category)
   : expenses = allExpenses.where((expense) =>expense.category == category).toList();
  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum = sum + expense.amount;
    }
    return sum;
  }
}
