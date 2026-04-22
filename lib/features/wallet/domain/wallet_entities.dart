enum TransactionType { deposit, withdraw, transfer }

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final String coinSymbol;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.type,
    required this.coinSymbol,
  });
}

class WalletAccount {
  final String id;
  final String name;
  final double balance;
  final String coinSymbol;
  final String color; // hex color string

  WalletAccount({
    required this.id,
    required this.name,
    required this.balance,
    required this.coinSymbol,
    required this.color,
  });
}
