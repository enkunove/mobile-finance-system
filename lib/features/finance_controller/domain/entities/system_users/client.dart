import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/system_user.dart';

class Client extends User {

  Client({
    required super.username,
    required super.password,
    required super.fullName,
    required super.passportSeriesAndNumber,
    required super.idNumber,
    required super.phone,
    required super.email,
    super.isApproved,
    required super.role

  });

  @override
  String toString() {
    return 'Client(username: $username, password: $password, role: $role, fullName: $fullName, passport: $passportSeriesAndNumber, idNumber: $idNumber, phone: $phone, email: $email, isApproved: $isApproved)';
  }
}
