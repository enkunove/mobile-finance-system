import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../../../core/injection_container.dart';
import '../../../domain/entities/system_users/client.dart';
import '../../../domain/entities/transfer.dart';
import '../../../domain/usecases/client_usecases/account_management_usecases.dart';

class TransferLogScreen extends StatefulWidget {
  const TransferLogScreen({super.key});

  @override
  State<TransferLogScreen> createState() => _TransferLogScreenState();
}

class _TransferLogScreenState extends State<TransferLogScreen> {
  late final AccountManagementUsecases _usecase;
  late final Client _client;

  @override
  void initState() {
    super.initState();
    _usecase = InjectionContainer.sl<AccountManagementUsecases>();
    _client = GetIt.instance<Client>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Журнал переводов'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<Transfer>>(
        future: _usecase.getAllTransferredForClient(_client.idNumber),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
           return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет переводов'));
          }

          final transfers = snapshot.data!;
          return ListView.builder(
            itemCount: transfers.length,
            itemBuilder: (context, index) {
              final transfer = transfers.reversed.toList()[index]; // изменили порядок
              final dateFormat = DateFormat('dd-MM-yyyy HH:mm');
              final formattedDate = dateFormat.format(transfer.dateTime);

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  leading: const Icon(Icons.transfer_within_a_station),
                  title: Text('Перевод: \$${transfer.amount.toStringAsFixed(2)}'),
                  subtitle: Text(
                      'От: ${transfer.source} \nКому: ${transfer.target}\nДата: $formattedDate'),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
