import 'package:flutter/material.dart';
import '../../domain/entities/system_users/client.dart';

class RequestWidget extends StatelessWidget {
  final Client client;
  final void Function(Client) onAccept;
  final void Function(Client) onReject;

  const RequestWidget({
    super.key,
    required this.client,
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
        boxShadow: [
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
          Text("Запрос клиента", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildInfoRow("Имя пользователя", client.username),
          _buildInfoRow("Полное имя", client.fullName),
          _buildInfoRow("Паспорт", client.passportSeriesAndNumber),
          _buildInfoRow("ID", client.idNumber.toString()),
          _buildInfoRow("Телефон", client.phone),
          _buildInfoRow("Email", client.email),
          _buildInfoRow("Одобрен", client.isApproved ? "Да" : "Нет"),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.close, color: Colors.red),
                onPressed: () => onReject(client),
              ),
              IconButton(
                icon: Icon(Icons.check, color: Colors.green),
                onPressed: () => onAccept(client),
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
          Text("$label: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
