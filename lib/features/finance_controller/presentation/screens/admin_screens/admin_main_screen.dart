import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/injection_container.dart';
import '../../../domain/entities/transfer.dart';
import '../../../domain/usecases/client_usecases/account_management_usecases.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() =>
      _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  late final AccountManagementUsecases _usecase;
  late Future<List<Transfer>> _transfersFuture;
  List<Transfer> _transfers = [];

  @override
  void initState() {
    super.initState();
    _usecase = InjectionContainer.sl<AccountManagementUsecases>();
    _loadTransfers();
  }

  void _loadTransfers() {
    setState(() {
      _transfersFuture = _usecase.getAllTransfers();
      _transfersFuture.then((data) {
        setState(() {
          _transfers = data.reversed.toList();
        });
      });
    });
  }

  void _removeTransfer(Transfer transfer) async {
    await _usecase.revertTransfer(transfer);
    setState(() {
      _transfers.remove(transfer);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('История переводов'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<Transfer>>(
        future: _transfersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }

          if (_transfers.isEmpty) {
            return const Center(child: Text('Нет переводов'));
          }

          return ListView.builder(
            itemCount: _transfers.length,
            itemBuilder: (context, index) {
              final transfer = _transfers[index];
              final dateFormat = DateFormat('dd-MM-yyyy HH:mm');
              final formattedDate = dateFormat.format(transfer.dateTime);

              return Card(
                margin: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  leading: const Icon(Icons.transfer_within_a_station),
                  title:
                  Text('Перевод: \$${transfer.amount.toStringAsFixed(2)}'),
                  subtitle: Text(
                      'От: ${transfer.source} \nКому: ${transfer.target}\nДата: $formattedDate'),
                  isThreeLine: true,
                  trailing: IconButton(
                    onPressed: () => _removeTransfer(transfer),
                    icon: const Icon(Icons.undo),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
