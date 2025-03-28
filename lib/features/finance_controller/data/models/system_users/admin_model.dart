import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/admin.dart';

class AdminModel extends Admin {

  AdminModel({
    required super.username,
    required super.password,
    required super.fullName,
    required super.passportSeriesAndNumber,
    required super.phone,
    required super.email,
    required super.role,
    super.idNumber = 0,
  });

  factory AdminModel.fromMap(Map<String, dynamic> map) {
    return AdminModel(
      username: map['username'],
      password: map['password'],
      fullName: map['fullName'],
      passportSeriesAndNumber: map['passportSeriesAndNumber'],
      phone: map['phone'],
      email: map['email'],
      idNumber: map['idNumber'] ?? 0,
      role: map['role']
    );
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
      'role': "Admin",
    };
  }
}
