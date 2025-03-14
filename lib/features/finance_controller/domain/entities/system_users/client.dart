import 'package:finance_system_controller/features/finance_controller/domain/entities/credit.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/system_user.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/transfer.dart';

import '../account.dart';

class Client extends User {
  @override
  String get role => "Client";
  final String fullName;
  final String passportSeriesAndNumber;
  final int idNumber = 0;
  final String phone;
  final String email;
  final List<Account> accounts;
  final List<Credit> credits;
  final List<Transfer> transfers;

  Client(super.username, super.password,
      {required this.fullName,
      required this.passportSeriesAndNumber,
      required this.phone,
      required this.email,
      List<Credit>? credits,
      List<Account>? accounts,
      List<Transfer>? transfers})
      : accounts = accounts ?? [],
        credits = credits ?? [],
        transfers = transfers ?? [];

  @override
  String toString() {
    return 'Client(username: $username, password: $password, role: $role, fullName: $fullName, passport: $passportSeriesAndNumber, idNumber: $idNumber, phone: $phone, email: $email, credits: $credits, transfers: $transfers, accounts: $accounts)';
  }
}
