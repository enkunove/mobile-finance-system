
class Account {
  int accountId = 0;
  final int clientId;
  final int bankId;
  double balance;
  bool isBlocked = false;
  bool isFrozen = false;

  Account({
    required this.clientId,
    required this.bankId,
    this.balance = 0.0,
    this.accountId = 0,
    this.isBlocked = false,
    this.isFrozen = false
  });

  @override
  String toString() {
    return "id: $accountId, clientId: $clientId, balance: $balance, isBlocked: $isBlocked, isFrozen: $isFrozen";
  }
}
