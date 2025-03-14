import 'package:flutter/material.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';
import 'package:get_it/get_it.dart';

class ClientMainScreen extends StatefulWidget {
  const ClientMainScreen({super.key});

  @override
  State<ClientMainScreen> createState() => _ClientMainScreenState();
}

class _ClientMainScreenState extends State<ClientMainScreen> {
  late Client _client;

  @override
  void initState() {
    super.initState();
    // Fetch the client from GetIt when the screen is loaded
    _client = GetIt.instance<Client>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ListTile(
              title: const Text('Username'),
              subtitle: Text(_client.username),
            ),
            ListTile(
              title: const Text('Id'),
              subtitle: Text(_client.idNumber.toString()),
            ),
            ListTile(
              title: const Text('Role'),
              subtitle: Text(_client.role.toString()),
            ),
            ListTile(
              title: const Text('Full Name'),
              subtitle: Text(_client.fullName),
            ),
            ListTile(
              title: const Text('Passport Series and Number'),
              subtitle: Text(_client.passportSeriesAndNumber),
            ),
            ListTile(
              title: const Text('Phone'),
              subtitle: Text(_client.phone),
            ),
            ListTile(
              title: const Text('Email'),
              subtitle: Text(_client.email),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // You can add actions like logging out or navigating elsewhere
              },
              child: const Text('Выйти'),
            ),
          ],
        ),
      ),
    );
  }
}
