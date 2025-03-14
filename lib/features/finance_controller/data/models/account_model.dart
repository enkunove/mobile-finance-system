import 'package:finance_system_controller/features/finance_controller/data/models/bank_model.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/account.dart';

class AccountModel extends Account{
  @override
  int accountId;
  @override
  final int clientId;
  final BankModel bankModel;
  @override
  double balance;
  @override
  bool isBlocked;
  @override
  bool isFrozen;

  AccountModel({
    this.accountId = 0,
    required this.clientId,
    required this.bankModel,
    this.balance = 0.0,
    this.isBlocked = false,
    this.isFrozen = false,
  }) : super(clientId: clientId, bank: bankModel);

  Map<String, dynamic> toMap() {
    return {
      'clientId': clientId,
      'bank': bankModel.toMap(),
      'balance': balance,
      'isBlocked': isBlocked ? 1 : 0,
      'isFrozen': isFrozen ? 1 : 0,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      accountId: map['accountId'],
      clientId: map['clientId'],
      bankModel: map['bank'],
      balance: map['balance'],
      isBlocked: map['isBlocked'] == 1,
      isFrozen: map['isFrozen'] == 1,
    );
  }
}
