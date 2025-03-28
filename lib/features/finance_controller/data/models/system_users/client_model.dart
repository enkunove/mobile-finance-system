import 'package:finance_system_controller/features/finance_controller/domain/entities/system_users/client.dart';

class ClientModel extends Client {
  ClientModel({
    required super.username,
    required super.password,
    required super.fullName,
    required super.passportSeriesAndNumber,
    required super.phone,
    required super.email,
    super.idNumber = 0,
    super.isApproved,
    required super.role
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'fullName': fullName,
      'passportSeriesAndNumber': passportSeriesAndNumber,
      'phone': phone,
      'email': email,
      'isApproved': isApproved ? 1 : 0,
      'role': role,
    };
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      username: map['username'] as String,
      password: map['password'] as String,
      fullName: map['fullName'] as String,
      passportSeriesAndNumber: map['passportSeriesAndNumber'] as String,
      idNumber: (map['idNumber'] ?? 0) as int,
      phone: map['phone'] as String,
      email: map['email'] as String,
      isApproved: (map['isApproved'] ?? 0) == 1,
      role: map['role']

    );
  }
}
