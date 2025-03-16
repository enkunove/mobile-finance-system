import 'package:finance_system_controller/features/finance_controller/domain/entities/credit.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/system_user.dart';
import 'package:finance_system_controller/features/finance_controller/domain/entities/transfer.dart';

import '../account.dart';

class Client extends User {
  @override
  String get role => "Client";
  final String fullName;
  final String passportSeriesAndNumber;
  final int idNumber;
  final String phone;
  final String email;
  bool isApproved;

  Client(super.username, super.password,
      {required this.fullName,
      required this.passportSeriesAndNumber,
      required this.idNumber,
      required this.phone,
      required this.email,
      required this.isApproved,
      });

  @override
  String toString() {
    return 'Client(username: $username, password: $password, role: $role, fullName: $fullName, passport: $passportSeriesAndNumber, idNumber: $idNumber, phone: $phone, email: $email, isApproved: $isApproved)';
  }
}
