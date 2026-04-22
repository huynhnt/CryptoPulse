import 'wallet_entities.dart';

abstract class WalletRepository {
  Future<List<WalletAccount>> getAccounts();
  Future<List<Transaction>> getTransactions();
  Future<void> addTransaction(Transaction transaction);
  Future<double> getTotalBalanceInUsd();
}
