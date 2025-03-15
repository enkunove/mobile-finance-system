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
              _buildBankHeader(),
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
                              AccountWidget(account: state.account!),
                              const SizedBox(height: 20),
                              _buildActionButtons(state.account, context),
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

  Widget _buildBankHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.account_balance, size: 40, color: Colors.blue),
              const SizedBox(width: 15),
              Text(
                widget.bank.name,
                style: const TextStyle(
                    fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Additional bank information:
          Text(
            "Тип: ${widget.bank.type}",
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            "BIC: ${widget.bank.bic}",
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            "PIN: ${widget.bank.pin}",
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            "Юридический адрес: ${widget.bank.address}",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(Account? account, BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        _buildActionButton(
          icon: Icons.arrow_downward,
          label: "Депозит",
          context: context,
          onPressed: () async {
            await _usecase.deposit(account!.accountId, 50);
            context.read<BankInfoBloc>().add(FetchBankInfo());
          },
        ),
        _buildActionButton(
          icon: Icons.arrow_upward,
          label: "Вывод",
          context: context,
          onPressed: () async {
            await _usecase.withdraw(account!.accountId, 50);
            context.read<BankInfoBloc>().add(FetchBankInfo());
          },
        ),
        _buildActionButton(
          icon: Icons.send,
          label: "Перевод",
          context: context,
          onPressed: () async {
            if (account!.balance > 0) {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return TransferDialog(balance: account.balance, id: account.accountId,);
                },
              );
              context.read<BankInfoBloc>().add(FetchBankInfo());
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Отсутствуют средства для перевода')),
              );
            }
          },
        ),
        _buildActionButton(
          icon: Icons.block,
          label: "Блокировка/разблокировка",
          context: context,
          onPressed: () async {
            await _usecase.blockAccount(account!.accountId);
            context.read<BankInfoBloc>().add(FetchBankInfo());
          },
        ),
        _buildActionButton(
          icon: Icons.ac_unit,
          label: "Заморозка/разморозка",
          context: context,
          onPressed: () async {
            await _usecase.freezeAccount(account!.accountId);
            context.read<BankInfoBloc>().add(FetchBankInfo());
          },
        ),
        _buildActionButton(
          icon: Icons.close,
          label: "Закрыть счет",
          context: context,
          onPressed: () async {
            await _usecase.closeAccount(account!.accountId);
            context.read<BankInfoBloc>().add(FetchBankInfo());
          },
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required BuildContext context,
  }) {
    return Builder(
        builder: (context) => ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),)
    );
  }
}
