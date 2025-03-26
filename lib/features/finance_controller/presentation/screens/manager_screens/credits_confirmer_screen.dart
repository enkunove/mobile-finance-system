import 'package:finance_system_controller/core/injection_container.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/credit.dart';
import 'package:finance_system_controller/features/finance_controller/domain/usecases/manager_usecases/manage_registration_usecases.dart';
import 'package:flutter/material.dart';
import '../../../domain/usecases/manager_usecases/manage_credits_usecases.dart';
import '../../widgets/credit_request_widget.dart';


class CreditsConfirmerScreen extends StatefulWidget {
  const CreditsConfirmerScreen({super.key});

  @override
  State<CreditsConfirmerScreen> createState() =>
      _CreditsConfirmerScreenState();
}

class _CreditsConfirmerScreenState
    extends State<CreditsConfirmerScreen> {
  late final ManageCreditsUsecases usecase;
  late Future<List<Credit>> _creditsFuture;

  @override
  void initState() {
    super.initState();
    usecase = InjectionContainer.sl<ManageCreditsUsecases>();
    _creditsFuture = fetchClients();
  }

  Future<List<Credit>> fetchClients() async {
    return await usecase.getAllRegistrationRequests();
  }

  void _removeClient(Credit credit) {
    setState(() {
      _creditsFuture = _creditsFuture.then((credits) {
        return credits.where((c) => c.id != credit.id).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text("Подтверждение кредитов"),
      ),
      body: FutureBuilder<List<Credit>>(
        future: _creditsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Ошибка: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Нет запросов на кредиты"));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final credit = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: CreditRequestWidget(
                    credit: credit,
                    onAccept: (Credit c) async {
                      await usecase.confirmRegistration(c);
                      _removeClient(c);
                    },
                    onReject: (Credit c) async {
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
