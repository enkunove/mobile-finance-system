import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/manager.dart';

class ManagerModel extends Manager {
  ManagerModel(
      {required super.username,
      required super.password,
      required super.fullName,
      required super.passportSeriesAndNumber,
      required super.idNumber,
      required super.phone,
      required super.email,
      required super.role
      });

  factory ManagerModel.fromMap(Map<String, dynamic> map) {
    return ManagerModel(
        username: map['username'] as String,
        password: map['password'] as String,
        fullName: map['fullName'] as String,
        passportSeriesAndNumber: map['passportSeriesAndNumber'] as String,
        idNumber: (map['idNumber'] ?? 0) as int,
        phone: map['phone'] as String,
        email: map['email'] as String,
        role: map['role']);
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'fullName': fullName,
      'passportSeriesAndNumber': passportSeriesAndNumber,
      'phone': phone,
      'email': email,
      'isApproved': 1,
      'role': "Manager",
    };
  }
}
