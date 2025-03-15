import 'package:flutter/material.dart';

import '../../../../core/injection_container.dart';
import '../../domain/usecases/client_usecases/account_management_usecases.dart';

class TransferDialog extends StatefulWidget {
  final double balance;
  final int id;

  const TransferDialog({super.key, required this.balance, required this.id});

  @override
  _TransferDialogState createState() => _TransferDialogState();
}

class _TransferDialogState extends State<TransferDialog> {
  final TextEditingController _idController = TextEditingController();
  late final AccountManagementUsecases _usecase;

  @override
  void initState() {
    super.initState();
    _usecase = InjectionContainer.sl<AccountManagementUsecases>();
  }

  double _transferAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Перевод средств'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _idController,
            decoration: const InputDecoration(
              labelText: 'ID счета для перевода',
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Сумма: ${_transferAmount.toStringAsFixed(2)}'),
              Text('Баланс: ${widget.balance.toStringAsFixed(2)}'),
            ],
          ),
          Slider(
            value: _transferAmount,
            min: 0,
            max: widget.balance,
            divisions: (widget.balance * 100).toInt(),
            label: _transferAmount.toStringAsFixed(2),
            onChanged: (double value) {
              setState(() {
                _transferAmount = value;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_idController.text.isNotEmpty && _transferAmount > 0) {
              final int targetId = int.tryParse(_idController.text) ?? -1;

              if (targetId != -1) {
                final target = await _usecase.getAccountById(targetId);
                if (target != null) {
                  await _usecase.transfer(
                      widget.id, targetId, _transferAmount);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Перевод выполнен')),
                  );
                } else {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Такого счета не существует')),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Неверный ID счета')),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Пожалуйста, заполните все поля')),
              );
            }
          },
          child: const Text('Перевести'),
        ),
      ],
    );
  }
}
