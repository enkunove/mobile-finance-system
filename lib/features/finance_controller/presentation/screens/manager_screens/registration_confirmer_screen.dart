import 'package:finance_system_controller/core/injection_container.dart';
import 'package:finance_system_controller/features/finance_controller/domain/usecases/manager_usecases/manage_registration_usecases.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/system_users/system_user.dart';
import '../../widgets/registration_request_widget.dart';

class RegistrationConfirmerScreen extends StatefulWidget {
  const RegistrationConfirmerScreen({super.key});

  @override
  State<RegistrationConfirmerScreen> createState() =>
      _RegistrationConfirmerScreenState();
}

class _RegistrationConfirmerScreenState
    extends State<RegistrationConfirmerScreen> {
  late final ManageRegistrationUsecases usecase;
  late Future<List<User>> _clientsFuture;

  @override
  void initState() {
    super.initState();
    usecase = InjectionContainer.sl<ManageRegistrationUsecases>();
    _clientsFuture = fetchClients();
  }

  Future<List<User>> fetchClients() async {
    return await usecase.getAllRegistrationRequests();
  }

  void _removeClient(User user) {
    setState(() {
      _clientsFuture = _clientsFuture.then((clients) {
        return clients.where((c) => c.idNumber != user.idNumber).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Подтверждение регистрации"),
      ),
      body: FutureBuilder<List<User>>(
        future: _clientsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Ошибка: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Нет запросов на регистрацию"));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: RequestWidget(
                    user: user,
                    onAccept: (User c) async {
                      await usecase.confirmRegistration(c);
                      _removeClient(c);
                    },
                    onReject: (User c) async {
                      await usecase.declineRegistration(c);
                      _removeClient(c);
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
