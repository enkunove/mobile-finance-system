import 'package:finance_system_controller/features/finance_controller/domain/entities/bank.dart';
import 'package:finance_system_controller/features/finance_controller/domain/repositories/bank_repository.dart';

import '../../entities/enterprise.dart';

class BankManagementUsecases{

  final BankRepository bankRepository;

  BankManagementUsecases(this.bankRepository);

  Future<void> createBank(int id, String type, String pin, String address, String name, String bic) async{
    Enterprise bank = Enterprise(id: id, type: type, pin: pin, address: address, name: name, bic: bic);
    await bankRepository.addBank(bank);
  }

  Future<List<Bank>> getAllBanks() async{
    return await bankRepository.getAllBanks();
  }
}