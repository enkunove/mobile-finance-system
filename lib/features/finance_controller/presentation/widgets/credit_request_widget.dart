import 'package:flutter/material.dart';
import '../../domain/entities/credit.dart';

class CreditRequestWidget extends StatelessWidget {
  final Credit credit;
  final void Function(Credit) onAccept;
  final void Function(Credit) onReject;

  const CreditRequestWidget({
    super.key,
    required this.credit,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Запрос клиента", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildInfoRow("ID пользователя", credit.clientId.toString()),
          _buildInfoRow("Срок (мес)", credit.months.toString()),
          _buildInfoRow("Проценты", credit.percentage.toString()),
          _buildInfoRow("Сумма", credit.amount.toString()),
          _buildInfoRow("Одобрен", credit.isApproved ? "Да" : "Нет"),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () => onReject(credit),
              ),
              IconButton(
                icon: const Icon(Icons.check, color: Colors.green),
                onPressed: () => onAccept(credit),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
