import 'package:dhanmanthan_original/models/debt.dart';
import 'package:riverpod/riverpod.dart';
import 'package:dhanmanthan_original/api/api.dart';

class DebtNotifier extends StateNotifier<List<Debt>> {
  final API api;

  DebtNotifier(this.api) : super([]) {
    _initializeDebts();
  }

  Future<void> _initializeDebts() async {
    try {
      print("Fetching debts from API...");
      final fetchedDebts = await api.fetchUserDebts();
      print("Fetched debts: $fetchedDebts");
      state = fetchedDebts;
    } catch (e) {
      print("Error fetching debts: $e");
      state = [];
    }
  }

  void add(Debt val) {
    state = [...state, val];
  }

  void remove(Debt val) {
    state = state.where((debt) => debt != val).toList();
  }

  void insert(int index, Debt val) {
    if (index < 0 || index > state.length) return;
    final newList = List<Debt>.from(state);
    newList.insert(index, val);
    state = newList;
  }
}

final apiProvider = Provider<API>((ref) {
  return API(); // Provide your API instance here
});

final debtProvider = StateNotifierProvider<DebtNotifier, List<Debt>>((ref) {
  final api = ref.read(apiProvider); // Get the API instance from the provider
  return DebtNotifier(api);
});
