import 'package:finance_system_controller/features/finance_controller/domain/entities/bank.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/bank_repository.dart';

class BankManagementUsecases{

  final BankRepository bankRepository;

  BankManagementUsecases({required this.bankRepository});

  Future<void> createBank(int id, String type, String pin, String address, String name, String bic) async{
    Bank bank = Bank(id: id, type: type, pin: pin, address: address, name: name, bic: bic);
    await bankRepository.addBank(bank);
  }
}