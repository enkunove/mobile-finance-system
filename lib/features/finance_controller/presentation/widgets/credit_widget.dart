import 'package:finance_system_controller/features/finance_controller/domain/entities/account.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/bloc/credit_state_management/credit_bloc.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/bloc/credit_state_management/credit_state.dart';
import 'package:finance_system_controller/features/finance_controller/presentation/bloc/credit_state_management/credit_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/credit.dart';
import '../bloc/bank_info_state_management/bank_info_bloc.dart';

class CreditWidget extends StatefulWidget {
  final Credit? credit;
  final Account? account;
  final BuildContext context;
  const CreditWidget(
      {super.key,
      required this.credit,
      required this.account,
      required this.context});

  @override
  State<CreditWidget> createState() => _CreditWidgetState();
}

class _CreditWidgetState extends State<CreditWidget> {
  final TextEditingController _sumController = TextEditingController();
  late CreditBloc _creditBloc;

  @override
  void initState() {
    _creditBloc = GetIt.instance<CreditBloc>(
        param1: widget.account, param2: widget.credit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _creditBloc,
      child: BlocBuilder<CreditBloc, CreditState>(
        builder: (context, state) {
          if (state.credit != null) {
            if (state.credit!.isApproved) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Кредит на сумму:",
                          style: TextStyle(fontSize: 16)),
                      Text(state.credit!.amount.toString(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const Text("Остаток для погашения:",
                          style: TextStyle(fontSize: 16)),
                      Text(state.credit!.remainedToPay.toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const Text("Ежемесячный платеж::",
                          style: TextStyle(fontSize: 16)),
                      Text(((state.credit!.amount + state.credit!.amount * state.credit!.percentage * 0.01) / state.credit!.months)
                          .toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            _creditBloc.add(PutMonthlyPayment());
                            context.read<BankInfoBloc>().add(FetchBankInfo());
                          },
                          icon: const Icon(Icons.add,
                              color: Colors.green, size: 20),
                          label: const Text("Внести ежемесячный платеж",
                              style: TextStyle(color: Colors.green)),
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Открытая заявка на кредит",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      const SizedBox(height: 10),
                      Text(
                          "Кредит на сумму: ${state.credit!.amount.toString()}"),
                      Text('Срок: ${state.credit!.months} месяца(ев)'),
                      const SizedBox(height: 20),
                      const Text("Ожидает подтверждение от менеджера"),
                      const SizedBox(height: 10),
                      Center(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            _creditBloc.add(CancelCreditRequestEvent());
                          },
                          icon: const Icon(Icons.close,
                              color: Colors.red, size: 20),
                          label: const Text("Отозвать заявку",
                              style: TextStyle(color: Colors.red)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Оформить заявку на кредит",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const SizedBox(height: 20),
                  DropdownMenu<int>(
                    width: 200,
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: 3, label: "3 месяца"),
                      DropdownMenuEntry(value: 6, label: "6 месяцев"),
                      DropdownMenuEntry(value: 12, label: "12 месяцев"),
                      DropdownMenuEntry(value: 24, label: "24 месяца"),
                    ],
                    initialSelection: state.term,
                    onSelected: (value) =>
                        _creditBloc.add(SelectTermEvent(value!)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Text("Процент переплат: "),
                      Text("${state.percentage}%",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _sumController,
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                    onChanged: (value) {
                      final parsed = double.tryParse(value) ?? 0.0;
                      _creditBloc.add(UpdateSumEvent(parsed));
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                      "Итоговая сумма: ${(state.sum + state.sum * double.parse(state.percentage) * 0.01).toStringAsFixed(2)}"),
                  const SizedBox(height: 20),
                  Center(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        _creditBloc.add(SendCreditRequestEvent(state.term,
                            double.parse(state.percentage), state.sum));
                      },
                      icon:
                          const Icon(Icons.add, color: Colors.green, size: 20),
                      label: const Text("Отправить заявку",
                          style: TextStyle(color: Colors.green)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
