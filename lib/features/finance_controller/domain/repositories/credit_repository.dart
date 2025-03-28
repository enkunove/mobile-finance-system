import '../entities/credit.dart';

abstract class CreditRepository{
  Future<void> openCreditRequest(Credit credit);
  Future<void> editCredit(Credit credit);
  Future<void> closeCredit(int id);
  Future<List<Credit>> getCreditsForClient(int clientId);
  Future<List<Credit>> getAllCredits();
  Future<Credit?> getCreditForAccount(int accountId);
  Future<Credit> getCreditById(int creditId);
}