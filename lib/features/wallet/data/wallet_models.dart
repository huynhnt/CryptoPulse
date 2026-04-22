import '../domain/wallet_entities.dart';

class TransactionModel extends Transaction {
  TransactionModel({
    required super.id,
    required super.title,
    required super.amount,
    required super.date,
    required super.type,
    required super.coinSymbol,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      title: json['title'],
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date']),
      type: TransactionType.values.firstWhere((e) => e.toString() == json['type']),
      coinSymbol: json['coinSymbol'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type.toString(),
      'coinSymbol': coinSymbol,
    };
  }
}

class WalletAccountModel extends WalletAccount {
  WalletAccountModel({
    required super.id,
    required super.name,
    required super.balance,
    required super.coinSymbol,
    required super.color,
  });

  factory WalletAccountModel.fromJson(Map<String, dynamic> json) {
    return WalletAccountModel(
      id: json['id'],
      name: json['name'],
      balance: (json['balance'] as num).toDouble(),
      coinSymbol: json['coinSymbol'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
      'coinSymbol': coinSymbol,
      'color': color,
    };
  }
}
