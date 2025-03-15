import 'package:finance_system_controller/core/injection_container.dart';
import 'package:finance_system_controller/features/finance_controller/domain/usecases/admin_usecases/banks_management_usecases.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/widgets/bank_widget.dart';
import 'package:flutter/material.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/entities/bank.dart';

class ClientMainScreen extends StatefulWidget {
  const ClientMainScreen({super.key});

  @override
  State<ClientMainScreen> createState() => _ClientMainScreenState();
}

class _ClientMainScreenState extends State<ClientMainScreen> {
  late final Client _client;
  late final BankManagementUsecases _usecase;

  @override
  void initState() {
    super.initState();
    _client = GetIt.instance<Client>();
    _usecase = InjectionContainer.sl<BankManagementUsecases>();
  }

  Future<List<Bank>> _fetchAccounts() async {
    return await _usecase.getAllBanks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(_client.username),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, "/client_main/profile"),
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, "/client_main/transfers"),
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Доступные банки",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Bank>>(
                future: _fetchAccounts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("ошибка: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("нет доступных банков"));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final account = snapshot.data![index];
                        return BankWidget(bank: account);
                      },
                    );
                  }
                },
              ),
            ),
            ]
        ),
      ),
    );
  }
}
