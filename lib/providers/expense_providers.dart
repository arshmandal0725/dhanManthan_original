import 'package:dhanmanthan_original/api/api.dart';
import 'package:dhanmanthan_original/models/expense.dart';
import 'package:riverpod/riverpod.dart';

class ExpenseNotifier extends StateNotifier<List<Expense>> {
  final API api;

  ExpenseNotifier(this.api) : super([]) {
    _initializeExpenses();
  }

  Future<void> _initializeExpenses() async {
    try {
      final fetchedExpenses = await api.fetchUserExpense(); // Fetch expenses from Firestore
      state = fetchedExpenses;
    } catch (e) {
      print("Error fetching expenses: $e");
      state = []; // Set an empty list or handle errors as needed
    }
  }

  void add(Expense val) {
    state = [...state, val];
  }

  void remove(Expense val) {
    state = state.where((expense) => expense != val).toList();
  }

  void insert(int index, Expense val) {
    if (index < 0 || index > state.length) return;
    final newList = List<Expense>.from(state);
    newList.insert(index, val);
    state = newList;
  }
}

final apiProvider = Provider<API>((ref) {
  return API(); // Provide your API instance here
});

final expenseProvider = StateNotifierProvider<ExpenseNotifier, List<Expense>>((ref) {
  final api = ref.read(apiProvider);
  return ExpenseNotifier(api);
});
