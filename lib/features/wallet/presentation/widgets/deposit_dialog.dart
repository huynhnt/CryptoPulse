import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crypto_pulse/core/constants/app_colors.dart';
import 'package:crypto_pulse/features/wallet/presentation/providers/wallet_provider.dart';
import 'package:crypto_pulse/features/wallet/domain/wallet_entities.dart';
import 'package:uuid/uuid.dart';

class DepositDialog extends ConsumerStatefulWidget {
  const DepositDialog({super.key});

  @override
  ConsumerState<DepositDialog> createState() => _DepositDialogState();
}

class _DepositDialogState extends ConsumerState<DepositDialog> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedCoin = 'USD';

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: const Text('Deposit Funds', style: TextStyle(color: AppColors.textPrimary)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: InputDecoration(
              labelText: 'Amount',
              labelStyle: const TextStyle(color: AppColors.textSecondary),
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: AppColors.divider)),
              focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primary)),
            ),
          ),
          const SizedBox(height: 20),
          DropdownButton<String>(
            value: _selectedCoin,
            dropdownColor: AppColors.surface,
            isExpanded: true,
            underline: Container(height: 1, color: AppColors.divider),
            items: ['USD', 'BTC', 'ETH'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value, style: const TextStyle(color: AppColors.textPrimary)),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedCoin = value!;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
        ),
        ElevatedButton(
          onPressed: () {
            final double? amount = double.tryParse(_amountController.text);
            if (amount != null && amount > 0) {
              // Thực hiện hành động: Cập nhật số dư
              ref.read(walletAccountsProvider.notifier).updateBalance(_selectedCoin, amount);
              
              // Thực hiện hành động: Thêm lịch sử giao dịch
              ref.read(walletTransactionsProvider.notifier).addTransaction(
                Transaction(
                  id: const Uuid().v4(),
                  title: 'Deposit $_selectedCoin',
                  amount: amount,
                  date: DateTime.now(),
                  type: TransactionType.deposit,
                  coinSymbol: _selectedCoin,
                ),
              );

              Navigator.pop(context);
              
              // Hiển thị thông báo thành công
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Succesfully deposited $amount $_selectedCoin'),
                  backgroundColor: AppColors.primary,
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
          child: const Text('Confirm', style: TextStyle(color: AppColors.background, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
