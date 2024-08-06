import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import "package:intl/intl.dart";

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Catgory { minus, plus }

const Map<Catgory, IconData> categoryIcon = {
  Catgory.minus: Icons.arrow_downward,
  Catgory.plus: Icons.arrow_upward
};

class Debt {
  Debt({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final Catgory category;
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

  factory Debt.fromJson(Map<String, dynamic> json) {
    return Debt(
      title: json['title'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
      category: Catgory.values.firstWhere(
        (e) => e.toString().split('.').last == json['category'],
      ),
    );
  }
}
