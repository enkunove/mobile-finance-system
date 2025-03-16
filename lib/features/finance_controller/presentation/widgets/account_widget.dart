import 'package:finance_system_controller/features/finance_controller/presentation/widgets/transfer_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/injection_container.dart';
import '../../domain/entities/account.dart';
import '../../domain/usecases/client_usecases/account_management_usecases.dart';
import '../bloc/bank_info_state_management/bank_info_bloc.dart';

class AccountWidget extends StatefulWidget {
  final Account account;
  final BuildContext buildContext;

  const AccountWidget({super.key, required this.account, required this.buildContext});

  @override
  State<AccountWidget> createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  late final AccountManagementUsecases _usecase;

  @override
  void initState() {
    super.initState();
    _usecase = InjectionContainer.sl<AccountManagementUsecases>();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle("Баланс", "\$${widget.account.balance.toStringAsFixed(2)}"),
            _buildStatus("Заблокирован", widget.account.isBlocked),
            _buildStatus("Заморожен", widget.account.isFrozen),
            _buildTitle("ID счета", widget.account.accountId.toString()),
            const SizedBox(height: 16),
            _buildActionButtons(widget.account, context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 16, color: Colors.black),
          children: [
            TextSpan(
              text: "$label: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  Widget _buildStatus(String label, bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isActive ? Colors.red.shade100 : Colors.green.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              isActive ? "Да" : "Нет",
              style: TextStyle(
                color: isActive ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(Account account, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: [
            _buildTransactionButton(
              icon: Icons.arrow_downward,
              label: "Депозит",
              color: Colors.green,
              onPressed: () async {
                await _usecase.deposit(account.accountId, 50);
                context.read<BankInfoBloc>().add(FetchBankInfo());
              },
            ),
            _buildTransactionButton(
              icon: Icons.arrow_upward,
              label: "Вывод",
              color: Colors.orange,
              onPressed: () async {
                await _usecase.withdraw(account.accountId, 50);
                context.read<BankInfoBloc>().add(FetchBankInfo());
              },
            ),
            _buildTransactionButton(
              icon: Icons.send,
              label: "Перевод",
              color: Colors.blue,
              onPressed: () async {
                if (account.balance > 0) {
                  await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return TransferDialog(
                        balance: account.balance,
                        id: account.accountId,
                      );
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
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          children: [
            _buildControlButton(
              icon: Icons.block,
              label: "Блокировка",
              color: Colors.purple,
              onPressed: () async {
                await _usecase.blockAccount(account.accountId);
                context.read<BankInfoBloc>().add(FetchBankInfo());
              },
            ),
            _buildControlButton(
              icon: Icons.ac_unit,
              label: "Заморозка",
              color: Colors.indigo,
              onPressed: () async {
                await _usecase.freezeAccount(account.accountId);
                context.read<BankInfoBloc>().add(FetchBankInfo());
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
            alignment: WrapAlignment.center,
          children:[ _buildDangerButton(
            icon: Icons.close,
            label: "Закрыть счет",
            onPressed: () async {
              await _usecase.closeAccount(account.accountId);
              context.read<BankInfoBloc>().add(FetchBankInfo());
            },
          ),
        ]),
      ],
    );
  }

  Widget _buildTransactionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white, size: 20),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color, size: 20),
      label: Text(label, style: TextStyle(color: color)),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildDangerButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white, size: 20),
        label: Text(label, style: const TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
    );
  }
}
