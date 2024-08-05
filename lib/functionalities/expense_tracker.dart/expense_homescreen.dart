import 'package:dhanmanthan_original/providers/expense_providers.dart';
import 'package:flutter/material.dart';
import 'package:dhanmanthan_original/models/expense.dart';
import 'package:dhanmanthan_original/functionalities/expense_tracker.dart/expense_list.dart';
import 'package:dhanmanthan_original/functionalities/expense_tracker.dart/new_expense.dart';
import 'package:dhanmanthan_original/widgets/chart/chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseHomescreen extends ConsumerStatefulWidget {
  const ExpenseHomescreen({super.key});

  @override
  ConsumerState createState() => _HomeState();
}

class _HomeState extends ConsumerState {
  void add(Expense exp) {
    ref.read(expenseProvider.notifier).add(exp);
  }

  void remove(Expense expense) {
    final indexOfExpense = ref.watch(expenseProvider).indexOf(expense);
    ref.read(expenseProvider.notifier).remove(expense);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      content: const Text("Expense Deleted"),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            ref.read(expenseProvider.notifier).insert(indexOfExpense, expense);
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text(
        "No Expences to Show,Try to add some",
        style: TextStyle(fontSize: 18),
      ),
    );
    if (ref.watch(expenseProvider).isNotEmpty) {
      (width <= 600)
          ? mainContent = Column(
              children: [
                Chart(expenses: ref.watch(expenseProvider)),
                Expanded(child: ExpenseList(ref.watch(expenseProvider), remove))
              ],
            )
          : mainContent = Row(
              children: [
                Expanded(child: Chart(expenses: ref.watch(expenseProvider))),
                Expanded(child: ExpenseList(ref.watch(expenseProvider), remove))
              ],
            );
    }
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 160, 203, 255),
          title: Text(
            'DhanManthan',
            style: GoogleFonts.abel(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                (width <= 600)
                    ? showModalBottomSheet(
                        context: context,
                        builder: (ctx) {
                          return NewExpense(add);
                        })
                    : showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (ctx) {
                          return NewExpense(add);
                        });
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ],
          centerTitle: true,
        ),
        body: mainContent);
  }
}
