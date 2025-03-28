import 'package:flutter/material.dart';
import '../../domain/entities/system_users/system_user.dart';

class RequestWidget extends StatelessWidget {
  final User user;
  final void Function(User) onAccept;
  final void Function(User) onReject;

  const RequestWidget({
    super.key,
    required this.user,
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
          _buildInfoRow("Имя пользователя", user.username),
          _buildInfoRow("Полное имя", user.fullName),
          _buildInfoRow("Паспорт", user.passportSeriesAndNumber),
          _buildInfoRow("ID", user.idNumber.toString()),
          _buildInfoRow("Телефон", user.phone),
          _buildInfoRow("Email", user.email),
          _buildInfoRow("Одобрен", user.isApproved ? "Да" : "Нет"),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () => onReject(user),
              ),
              IconButton(
                icon: const Icon(Icons.check, color: Colors.green),
                onPressed: () => onAccept(user),
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
