import 'package:finance_system_controller/features/finance_controller/domain/entities/transfer.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

import '../../../../../core/injection_container.dart';
import '../../../domain/entities/system_users/client.dart';
import '../../../domain/usecases/client_usecases/account_management_usecases.dart';

class BankEnterprisesScreen extends StatefulWidget {
  final int id;
  const BankEnterprisesScreen(this.id, {super.key});

  @override
  State<BankEnterprisesScreen> createState() => _BankEnterprisesScreenState();
}

class _BankEnterprisesScreenState extends State<BankEnterprisesScreen> {
  late final Client _client;
  late final AccountManagementUsecases _usecase;


  @override
  void initState() {
    super.initState();
    _client = GetIt.instance<Client>();
    _usecase = InjectionContainer.sl<AccountManagementUsecases>();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Информация по предприятиям банка'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<Transfer>>(
        future: _usecase.getAllTransfers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет зарегестрированных в банке предприятий'));
          }

          final enterprises = snapshot.data!;
          return ListView.builder(
            itemCount: enterprises.length,
            itemBuilder: (context, index) {
              final transfer = enterprises.reversed.toList()[index];
              final dateFormat = DateFormat('dd-MM-yyyy HH:mm');
              final formattedDate = dateFormat.format;

              return const Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                ),
              );
            },
          );
        },
      ),
    );
  }
}
