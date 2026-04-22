import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crypto_pulse/features/wallet/data/wallet_repository_impl.dart';
import 'package:crypto_pulse/features/wallet/domain/wallet_entities.dart';

// Class quản lý trạng thái của danh sách giao dịch
class WalletTransactionsNotifier extends StateNotifier<AsyncValue<List<Transaction>>> {
  final WalletRepositoryImpl _repository;

  WalletTransactionsNotifier(this._repository) : super(const AsyncValue.loading()) {
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    try {
      final transactions = await _repository.getTransactions();
      state = AsyncValue.data(List.from(transactions));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void addTransaction(Transaction transaction) {
    if (state.hasValue) {
      final currentList = state.value!;
      state = AsyncValue.data([transaction, ...currentList]);
    }
  }
}

// Class quản lý trạng thái của các tài khoản ví
class WalletAccountsNotifier extends StateNotifier<AsyncValue<List<WalletAccount>>> {
  final WalletRepositoryImpl _repository;

  WalletAccountsNotifier(this._repository) : super(const AsyncValue.loading()) {
    _loadAccounts();
  }

  Future<void> _loadAccounts() async {
    try {
      final accounts = await _repository.getAccounts();
      state = AsyncValue.data(List.from(accounts));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void updateBalance(String coinSymbol, double amount) {
    if (state.hasValue) {
      final currentAccounts = state.value!;
      final updatedAccounts = currentAccounts.map((account) {
        if (account.coinSymbol == coinSymbol) {
          return WalletAccount(
            id: account.id,
            name: account.name,
            balance: account.balance + amount,
            coinSymbol: account.coinSymbol,
            color: account.color,
          );
        }
        return account;
      }).toList();
      state = AsyncValue.data(updatedAccounts);
    }
  }
}

// Providers
final walletRepositoryProvider = Provider<WalletRepositoryImpl>((ref) => WalletRepositoryImpl());

final walletTransactionsProvider = StateNotifierProvider<WalletTransactionsNotifier, AsyncValue<List<Transaction>>>((ref) {
  final repo = ref.watch(walletRepositoryProvider);
  return WalletTransactionsNotifier(repo);
});

final walletAccountsProvider = StateNotifierProvider<WalletAccountsNotifier, AsyncValue<List<WalletAccount>>>((ref) {
  final repo = ref.watch(walletRepositoryProvider);
  return WalletAccountsNotifier(repo);
});

// Provider tính tổng số dư động dựa trên các account hiện tại
final totalWalletBalanceProvider = Provider<double>((ref) {
  final accountsAsync = ref.watch(walletAccountsProvider);
  return accountsAsync.maybeWhen(
    data: (accounts) {
      // Giả lập tính toán đơn giản: quy đổi BTC/ETH ra USD ảo
      double total = 0;
      for (var account in accounts) {
        if (account.coinSymbol == 'USD') total += account.balance;
        if (account.coinSymbol == 'BTC') total += account.balance * 65000;
        if (account.coinSymbol == 'ETH') total += account.balance * 3500;
      }
      return total;
    },
    orElse: () => 45670.25,
  );
});
