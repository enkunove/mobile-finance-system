import 'package:flutter/material.dart';
import '../../domain/entities/account.dart';

class AccountWidget extends StatefulWidget {
  final Account account;

  const AccountWidget({super.key, required this.account});

  @override
  State<AccountWidget> createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle("Баланс", "\$${widget.account.balance.toStringAsFixed(2)}"),
            _buildStatus("Заблокирован", widget.account.isBlocked),
            _buildStatus("Заморожен", widget.account.isFrozen),
            _buildTitle("ID счета", widget.account.accountId.toString()),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black),
          children: [
            TextSpan(
              text: "$label: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  Widget _buildStatus(String label, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isActive ? Colors.red.shade100 : Colors.green.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              isActive ? "Да" : "Нет",
              style: TextStyle(
                color: isActive ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
