import '../entities/bank.dart';

abstract class BankRepository {
  Future<List<Bank>> getAllBanks();
  Future<Bank> getBankById(int id);
  Future<bool> addBank(Bank bank);
  Future<bool> updateBank(Bank bank);
  Future<bool> deleteBank(int id);
}
