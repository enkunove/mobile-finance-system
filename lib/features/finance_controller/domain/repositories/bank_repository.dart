import '../entities/bank.dart';
import '../entities/enterprise.dart';

abstract class BankRepository {
  Future<List<Bank>> getAllBanks();
  Future<Bank> getBankById(int id);
  Future<bool> addBank(Enterprise bank);
  Future<bool> updateBank(Bank bank);
  Future<bool> deleteBank(int id);
}
