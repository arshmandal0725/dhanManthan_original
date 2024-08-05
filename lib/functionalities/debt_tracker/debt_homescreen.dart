import 'package:dhanmanthan_original/providers/debt_providers.dart';
import 'package:flutter/material.dart';
import 'package:dhanmanthan_original/models/debt.dart';
import 'package:dhanmanthan_original/functionalities/debt_tracker/debt_list.dart';
import 'package:dhanmanthan_original/functionalities/debt_tracker/new_debt.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeDebt extends ConsumerStatefulWidget {
  const HomeDebt({super.key});

  @override
  ConsumerState createState() => _HomeDebtState();
}

class _HomeDebtState extends ConsumerState {
  void add(Debt exp) {
    ref.read(debtProvider.notifier).add(exp);
  }

  void remove(Debt expense) {
    final indexOfExpense = ref.watch(debtProvider).indexOf(expense);
    ref.read(debtProvider.notifier).remove(expense);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      content: const Text("Debt Deleted"),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              ref.read(debtProvider).insert(indexOfExpense, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget mainContent = const Center(
      child: Text(
        "No Debt to Show,Try to add some",
        style: TextStyle(fontSize: 18),
      ),
    );
    if (ref.watch(debtProvider).isNotEmpty) {
      (width <= 600)
          ? mainContent = Column(
              children: [Expanded(child: ExpenseList(ref.watch(debtProvider), remove))],
            )
          : mainContent = Row(
              children: [Expanded(child: ExpenseList(ref.watch(debtProvider), remove))],
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
