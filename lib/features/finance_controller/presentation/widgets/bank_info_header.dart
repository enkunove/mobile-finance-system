import 'package:flutter/material.dart';

import '../../domain/entities/bank.dart';
import '../screens/client_screens/bank_enterprises_screen.dart';

class BankInfoHeader extends StatefulWidget {
  final Bank bank;
  const BankInfoHeader({super.key, required this.bank});

  @override
  State<BankInfoHeader> createState() => _BankInfoHeaderState();
}

class _BankInfoHeaderState extends State<BankInfoHeader> {
  @override
  Widget build(BuildContext context) {
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
          Text(
            "Юридический адрес: ${widget.bank.specialistId}",
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10,),
          TextButton(onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => BankEnterprisesScreen(widget.bank.id)),
            );
          }, child: const Text("Перейти к предприятиям банка"))
        ],
      ),
    );
  }
}
