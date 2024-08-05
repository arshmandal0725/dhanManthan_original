import 'package:dhanmanthan_original/models/debt.dart';
import 'package:riverpod/riverpod.dart';

class DebtNotifier extends StateNotifier<List<Debt>> {
  DebtNotifier() : super([]);

  void add(Debt val) {
    state = [...state, val];
  }

  void remove(Debt val) {
    state = state.where((expense) => expense != val).toList();
  }

  void insert(int index, Debt val) {
    if (index < 0 || index > state.length) return;
    final newList = List<Debt>.from(state);
    newList.insert(index, val);
    state = newList;
  }
}

final debtProvider =
    StateNotifierProvider<DebtNotifier, List<Debt>>((ref) => DebtNotifier());
