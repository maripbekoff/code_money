import 'package:code_money/src/models/remote/transactions/transaction_model.dart';
import 'package:flutter/cupertino.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    Key? key,
    required this.transaction,
    required this.onDissmissed,
    required this.confirmDismiss,
  }) : super(key: key);

  final TransactionModel transaction;
  final Function(DismissDirection direction) onDissmissed;
  final Future<bool> Function(DismissDirection direction) confirmDismiss;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(transaction.hashCode),
      background: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.systemRed,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          CupertinoIcons.trash,
          color: CupertinoColors.white,
        ),
      ),
      secondaryBackground: Container(
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          CupertinoIcons.pencil,
          color: CupertinoColors.white,
        ),
      ),
      onDismissed: onDissmissed,
      confirmDismiss: confirmDismiss,
      child: Container(
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
              crossAxisAlignment: CrossAxisAlignment.end,
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
                  dateFromDateTimeToString(transaction.date),
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
