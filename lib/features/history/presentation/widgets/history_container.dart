import 'package:easy_bank/core/resources/app_colors.dart';
import 'package:easy_bank/features/history/domain/entities/transaction_history.dart';
import 'package:flutter/material.dart';

class HistoryContainer extends StatelessWidget {
  final TransactionHistory transactionHistory;
  const HistoryContainer({super.key, required this.transactionHistory});

  @override
  Widget build(BuildContext context) {
    late final IconData icon;
    late final Color typeColor;

    if (transactionHistory.type == 'Debit') {
      icon = Icons.arrow_downward;
      typeColor = AppColors.error;
    } else {
      icon = Icons.arrow_upward;
      typeColor = AppColors.green;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: typeColor),
                      SizedBox(width: 8),
                      Text(
                        transactionHistory.type,
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: typeColor,
                                ),
                      ),
                    ],
                  ),
                  Text(
                    'RS. ${transactionHistory.amount.toStringAsFixed(1)}',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: typeColor,
                        ),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey.shade300),
            transactionHistory.type == 'Credit'
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sender: ${transactionHistory.sender.name}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Account: ${transactionHistory.sender.accNumber}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Receiver: ${transactionHistory.receiver.name}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Account: ${transactionHistory.receiver.accNumber}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
