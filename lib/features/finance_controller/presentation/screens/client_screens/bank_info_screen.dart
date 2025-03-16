import 'package:finance_system_controller/features/finance_controller/presentation/widgets/bank_info_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/injection_container.dart';
import '../../../domain/entities/account.dart';
import '../../../domain/entities/bank.dart';
import '../../../domain/entities/system_users/client.dart';
import '../../../domain/usecases/client_usecases/account_management_usecases.dart';
import '../../bloc/bank_info_state_management/bank_info_bloc.dart';
import '../../widgets/account_widget.dart';
import '../../widgets/transfer_dialog_widget.dart';

class BankInfoScreen extends StatefulWidget {
  final Bank bank;
  const BankInfoScreen({super.key, required this.bank});

  @override
  State<BankInfoScreen> createState() => _BankInfoScreenState();
}

class _BankInfoScreenState extends State<BankInfoScreen> {
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
    return BlocProvider<BankInfoBloc>(
      create: (context) => InjectionContainer.sl<BankInfoBloc>(
        param1: _client,
        param2: widget.bank,
      )..add(FetchBankInfo()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(widget.bank.name),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              BankInfoHeader(bank: widget.bank),
              const SizedBox(height: 20),
              Expanded(
                child: BlocBuilder<BankInfoBloc, BankInfoState>(
                  builder: (context, state) {
                    if (state is BankInfoLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is BankInfoLoaded) {
                      if (state.account != null) {
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              AccountWidget(account: state.account!, buildContext: context,),
                              const SizedBox(height: 20),
                            ],
                          ),
                        );
                      } else {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Счет не найден",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            Builder(
                              builder: (context) => ElevatedButton(
                                onPressed: () async {
                                  await _usecase.createAccount(_client, widget.bank);
                                  context.read<BankInfoBloc>().add(FetchBankInfo());
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 50),
                                ),
                                child: const Text(
                                  'Открыть счет в банке',
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
