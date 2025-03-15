import 'package:finance_system_controller/core/injection_container.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/account.dart';
import 'package:finance_system_controller/features/finance_controller/domain/usecases/client_usecases/account_management_usecases.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/widgets/account_widget.dart';
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
  late final AccountManagementUsecases _usecase;

  @override
  void initState() {
    super.initState();
    _client = GetIt.instance<Client>();
    _usecase = InjectionContainer.sl<AccountManagementUsecases>();
  }

  void _test() async {
    Bank bank = Bank(
      id: 1,
      type: "type",
      pin: "pin",
      address: "address",
      name: "name",
      bic: "bic",
    );
    final usecase = InjectionContainer.sl<AccountManagementUsecases>();
    await usecase.createAccount(_client, bank);
    setState(() {});
  }

  void _test2() async {
    final usecase = InjectionContainer.sl<AccountManagementUsecases>();
    await usecase.deposit(2, 100);
    setState(() {});
  }

  Future<List<Account>> _fetchAccounts() async {
    return await _usecase.getAccountsForClient(_client);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Client Dashboard"),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, "/client_main/profile"),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Accounts",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: FutureBuilder<List<Account>>(
                future: _fetchAccounts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No accounts available"));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final account = snapshot.data![index];
                        return AccountWidget(account: account);
                      },
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _test,
                  child: const Text("Create Account"),
                ),
                ElevatedButton(
                  onPressed: _test2,
                  child: const Text("Deposit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
