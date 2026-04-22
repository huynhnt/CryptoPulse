import '../domain/wallet_entities.dart';
import '../domain/wallet_repository.dart';
import 'wallet_models.dart';

class WalletRepositoryImpl implements WalletRepository {
  final List<Transaction> _mockTransactions = [
    TransactionModel(
      id: '1',
      title: 'Deposit Bitcoin',
      amount: 0.05,
      date: DateTime.now().subtract(const Duration(days: 1)),
      type: TransactionType.deposit,
      coinSymbol: 'BTC',
    ),
    TransactionModel(
      id: '2',
      title: 'Bought Ethereum',
      amount: 1.2,
      date: DateTime.now().subtract(const Duration(hours: 5)),
      type: TransactionType.deposit,
      coinSymbol: 'ETH',
    ),
    TransactionModel(
      id: '3',
      title: 'Withdraw to Bank',
      amount: 500.0,
      date: DateTime.now().subtract(const Duration(days: 3)),
      type: TransactionType.withdraw,
      coinSymbol: 'USD',
    ),
  ];

  @override
  Future<List<WalletAccount>> getAccounts() async {
    return [
      WalletAccountModel(
        id: '1',
        name: 'Main Spot Wallet',
        balance: 12450.85,
        coinSymbol: 'USD',
        color: '0xFF00FF41',
      ),
      WalletAccountModel(
        id: '2',
        name: 'HODL Bitcoin',
        balance: 0.45,
        coinSymbol: 'BTC',
        color: '0xFFF7931A',
      ),
      WalletAccountModel(
        id: '3',
        name: 'Trading ETH',
        balance: 5.2,
        coinSymbol: 'ETH',
        color: '0xFF627EEA',
      ),
    ];
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    return _mockTransactions;
  }

  @override
  Future<void> addTransaction(Transaction transaction) async {
    _mockTransactions.insert(0, transaction);
  }

  @override
  Future<double> getTotalBalanceInUsd() async {
    return 45670.25; // Giả lập tổng tài sản quy đổi ra USD
  }
}
