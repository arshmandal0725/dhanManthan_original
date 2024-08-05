import 'package:dhanmanthan_original/models/expense.dart';
import 'package:riverpod/riverpod.dart';

class ExpenseNotifier extends StateNotifier<List<Expense>> {
  ExpenseNotifier() : super([]);
  void add(Expense val) {
    state = [...state, val];
  }

  void remove(Expense val){
     state = state.where((expense) => expense != val).toList();
  }

  void insert(int index,Expense val)
  {
     if (index < 0 || index > state.length) return;
    final newList = List<Expense>.from(state);
    newList.insert(index, val);
    state = newList;
  }
}

final expenseProvider =
    StateNotifierProvider<ExpenseNotifier, List<Expense>>((ref) {
  return ExpenseNotifier();
});
