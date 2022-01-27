import 'package:code_money/src/models/remote/transactions/transaction_model.dart';
import 'package:flutter/cupertino.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey6,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            transaction.wallet,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Column(
            children: [
              Text(
                '${transaction.isAdmission ?? false ? '+' : '-'} ${transaction.sum.abs()} ₸',
                style: TextStyle(
                  color: transaction.isAdmission ?? false
                      ? CupertinoColors.activeGreen
                      : CupertinoColors.systemRed,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                transaction.date,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
